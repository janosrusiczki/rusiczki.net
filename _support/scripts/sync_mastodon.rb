#!/usr/bin/env ruby
# Nightly sync of new Mastodon toots into _microblog/mastodon/.
#
# Required env:
#   MASTODON_INSTANCE  e.g. "mastodon.social"
#   MASTODON_HANDLE    your handle without the leading @
#
# Optional env:
#   MASTODON_TOKEN     bearer token, raises rate limits and lets you see your
#                      own unlisted toots (public toots work without it)
#
# Walks the public statuses API forward from the highest source_id already on
# disk, keeps originals (no boosts, no replies-to-others; self-replies stay),
# converts each toot's HTML body to Markdown, and downloads media into
# _microblog_media_staging/mastodon/. The accompanying GitHub Action rsyncs
# that staging dir to content.rusiczki.net and commits the new entries.
#
# Quote posts (Boost → Quote on mastodon.social) are handled like boosts but
# preserve your commentary above the quoted content rendered as a blockquote.

require 'bundler/setup'
require 'httparty'
require 'reverse_markdown'
require 'json'
require 'fileutils'
require 'shellwords'
require 'time'
require 'uri'
require 'yaml'

REPO_ROOT         = File.expand_path('../..', __dir__)
ENTRIES_DIR       = File.join(REPO_ROOT, '_microblog', 'mastodon')
MEDIA_STAGING     = File.join(REPO_ROOT, '_microblog_media_staging', 'mastodon')
PUBLIC_MEDIA_BASE = 'https://content.rusiczki.net/microblog/mastodon'
PAGE_SIZE         = 40

instance = ENV.fetch('MASTODON_INSTANCE') { abort 'MASTODON_INSTANCE not set' }
handle   = ENV.fetch('MASTODON_HANDLE')   { abort 'MASTODON_HANDLE not set' }
token    = ENV['MASTODON_TOKEN']

FileUtils.mkdir_p(ENTRIES_DIR)
FileUtils.mkdir_p(MEDIA_STAGING)

api_base = "https://#{instance}/api/v1"
auth_headers = token ? { 'Authorization' => "Bearer #{token}" } : {}

# Look up the account id on the home instance
lookup = HTTParty.get("#{api_base}/accounts/lookup",
                      query: { acct: handle },
                      headers: auth_headers)
abort "Account lookup failed (#{lookup.code}): #{lookup.body}" unless lookup.success?
account = JSON.parse(lookup.body)
account_id = account['id']
puts "Account: @#{handle}@#{instance} (id=#{account_id})"

# Highest existing source_id on disk — read front matter from each .md
def highest_existing_id(dir)
  return nil unless Dir.exist?(dir)
  ids = []
  Dir.glob(File.join(dir, '**', '*.md')).each do |path|
    head = File.foreach(path).first(20).join
    if head =~ /\A---\s*\n(.*?)\n---/m
      front = YAML.safe_load(Regexp.last_match(1), permitted_classes: [Time])
      id = front && front['source_id']
      ids << id.to_s if id
    end
  end
  return nil if ids.empty?
  ids.max_by(&:to_i)
end

since_id = highest_existing_id(ENTRIES_DIR)
puts "Highest existing toot id: #{since_id || '(none — first run)'}"

# Walk forward in batches. Mastodon's min_id returns the OLDEST page newer
# than the cursor, in reverse chronological order within each page. After each
# page, advance the cursor to the newest id we've just seen.
new_statuses = []
cursor = since_id
loop do
  params = { limit: PAGE_SIZE }
  params[:min_id] = cursor if cursor
  resp = HTTParty.get("#{api_base}/accounts/#{account_id}/statuses",
                      query: params,
                      headers: auth_headers)
  abort "Statuses fetch failed (#{resp.code}): #{resp.body}" unless resp.success?
  batch = JSON.parse(resp.body)
  break if batch.empty?
  new_statuses.concat(batch)
  cursor = batch.first['id'] # newest in batch (responses are reverse-chrono)
  break if batch.size < PAGE_SIZE
end
puts "Fetched #{new_statuses.size} status(es) newer than the last sync"

def keep?(status, my_account_id)
  # Boosts and quote posts are kept; replies-to-others are skipped.
  return true if status['reblog']
  return true if status.dig('quote', 'quoted_status')
  reply_to = status['in_reply_to_account_id']
  return false if reply_to && reply_to.to_s != my_account_id.to_s
  true
end

def safe_media_filename(file_prefix, media_url, index)
  basename = File.basename(URI.parse(media_url).path) rescue nil
  basename = "#{index}.bin" if basename.nil? || basename.empty?
  "#{file_prefix}-#{basename}"
end

# If the downloaded image is wider than 1000px, produce a proportionally
# resized copy at 1000px wide in staged_dir. Returns [display_filename,
# original_filename] — display is the resized copy when one was made,
# otherwise both are the original. Falls back gracefully on non-image files.
def resize_for_web(src_path, staged_dir)
  ext         = File.extname(src_path)
  basename    = File.basename(src_path)
  base_no_ext = File.basename(src_path, ext)

  dims = `identify -format "%wx%h" #{Shellwords.escape(src_path)} 2>/dev/null`.strip
  w, h = dims.split('x').map(&:to_i)
  return [basename, basename] unless w && w > 1000

  new_h        = (h * 1000.0 / w).round
  resized_name = "#{base_no_ext}-1000x#{new_h}#{ext}"
  resized_path = File.join(staged_dir, resized_name)

  system("convert #{Shellwords.escape(src_path)} -resize 1000x #{Shellwords.escape(resized_path)}") \
    unless File.exist?(resized_path)

  File.exist?(resized_path) ? [resized_name, basename] : [basename, basename]
end

# Download media attachments for a status payload; return [lines, staged, failed].
# file_prefix is prepended to each saved filename to avoid collisions.
def stage_media(payload, file_prefix)
  lines  = []
  staged = 0
  failed = 0
  Array(payload['media_attachments']).each_with_index do |m, i|
    src = m['url']
    next unless src
    filename = safe_media_filename(file_prefix, src, i)
    dest = File.join(MEDIA_STAGING, filename)
    if File.exist?(dest)
      staged += 1
    else
      resp = HTTParty.get(src, follow_redirects: true)
      if resp.success?
        File.binwrite(dest, resp.body)
        staged += 1
      else
        failed += 1
        warn "  media download failed (#{resp.code}): #{src}"
        next
      end
    end
    alt = m['description'].to_s.gsub(/\s*\n\s*/, ' ').strip
    display_name, original_name = resize_for_web(dest, MEDIA_STAGING)
    display_url  = "#{PUBLIC_MEDIA_BASE}/#{display_name}"
    original_url = "#{PUBLIC_MEDIA_BASE}/#{original_name}"
    lines << "[![#{alt}](#{display_url})](#{original_url}){:.glightbox}"
  end
  [lines, staged, failed]
end

written        = 0
skipped        = 0
media_staged   = 0
media_failed   = 0

new_statuses.each do |status|
  unless keep?(status, account_id)
    skipped += 1
    next
  end

  toot_id    = status['id']
  created_at = Time.parse(status['created_at']).utc
  date_iso   = created_at.strftime('%Y-%m-%d')
  date_full  = created_at.strftime('%Y-%m-%d %H:%M:%S +0000')
  year       = created_at.strftime('%Y')

  is_boost  = !status['reblog'].nil?
  payload   = is_boost ? status['reblog'] : status
  boost_of  = is_boost ? "@#{payload.dig('account', 'acct')}" : nil

  quoted_status = !is_boost && status.dig('quote', 'quoted_status')
  is_quote      = !!quoted_status
  quote_of      = is_quote ? "@#{quoted_status.dig('account', 'acct')}" : nil
  quoted_url    = is_quote ? quoted_status['url'] : nil

  # HTML → Markdown
  body_md = ReverseMarkdown.convert(payload['content'].to_s,
                                    unknown_tags: :bypass,
                                    github_flavored: false).strip

  # Strip the mastodon.social-injected "RE: [url](url)" fallback line from
  # quote posts — we render the actual quoted content as a blockquote below.
  if is_quote && quoted_url
    body_md = body_md.sub(
      /RE:\s*\[#{Regexp.escape(quoted_url)}\]\(#{Regexp.escape(quoted_url)}\)\n*/,
      ''
    ).strip
  end

  # Content warning prepended as a blockquote
  spoiler = payload['spoiler_text'].to_s.strip
  body_md = "> CW: #{spoiler}\n\n#{body_md}" unless spoiler.empty?

  # Media for the main payload
  media_lines, ms, mf = stage_media(payload, toot_id)
  media_staged += ms
  media_failed += mf
  body_md += "\n\n" + media_lines.join("\n\n") unless media_lines.empty?

  # Quote post: append the quoted content as an attributed blockquote
  if is_quote
    quoted_md = ReverseMarkdown.convert(quoted_status['content'].to_s,
                                        unknown_tags: :bypass,
                                        github_flavored: false).strip
    quoted_spoiler = quoted_status['spoiler_text'].to_s.strip
    quoted_md = "> CW: #{quoted_spoiler}\n\n#{quoted_md}" unless quoted_spoiler.empty?

    q_media_lines, ms, mf = stage_media(quoted_status, "#{toot_id}-q")
    media_staged += ms
    media_failed += mf
    quoted_md += "\n\n" + q_media_lines.join("\n\n") unless q_media_lines.empty?

    attribution = "— [#{quote_of}](#{quoted_url})"
    blockquote  = (quoted_md + "\n\n" + attribution)
                    .split("\n")
                    .map { |l| l.empty? ? '>' : "> #{l}" }
                    .join("\n")

    body_md = [body_md, blockquote].reject(&:empty?).join("\n\n")
  end

  lang_value = payload['language'] == 'ro' ? 'ro' : 'en'
  source_url = is_quote \
    ? (status['url'] || "https://#{instance}/@#{handle}/#{toot_id}") \
    : (payload['url'] || "https://#{instance}/@#{handle}/#{toot_id}")

  out_dir  = File.join(ENTRIES_DIR, year)
  FileUtils.mkdir_p(out_dir)
  out_file = File.join(out_dir, "#{date_iso}-#{toot_id}.md")

  File.open(out_file, 'w') do |f|
    f.puts '---'
    f.puts %(title: "Microblog #{created_at.strftime('%Y-%m-%d %H:%M UTC')}")
    f.puts "date: #{date_full}"
    f.puts 'source: mastodon'
    f.puts %(source_id: "#{toot_id}")
    f.puts "source_url: #{source_url}"
    f.puts "lang: #{lang_value}"
    f.puts %(slug: "#{toot_id}")
    f.puts %(boost_of: "#{boost_of}") if boost_of
    f.puts %(quote_of: "#{quote_of}") if quote_of
    f.puts '---'
    f.puts body_md
  end
  written += 1
end

puts
puts "Written:       #{written}"
puts "Skipped:       #{skipped}"
puts "Media staged:  #{media_staged}"
puts "Media failed:  #{media_failed}"
