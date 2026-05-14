#!/usr/bin/env ruby
# One-shot importer for a Twitter/X archive zip.
#
#   ruby _support/scripts/import_twitter.rb path/to/twitter-archive.zip
#
# Reads tweets.js (or tweets-part*.js) and account.js from inside the zip,
# keeps original tweets only (no retweets, no replies-to-others), copies
# attached media into _microblog_media_staging/twitter/, and writes one
# Markdown file per tweet under _microblog/twitter/<year>/.
#
# Media URLs in the generated Markdown point at
# https://content.rusiczki.net/microblog/twitter/... — you upload the staging
# dir there with rsync after running this script.

require 'bundler/setup'
require 'json'
require 'fileutils'
require 'time'
require 'tmpdir'
require 'uri'
require 'zip'

REPO_ROOT         = File.expand_path('../../..', __dir__)
ENTRIES_DIR       = File.join(REPO_ROOT, '_microblog', 'twitter')
MEDIA_STAGING     = File.join(REPO_ROOT, '_microblog_media_staging', 'twitter')
PUBLIC_MEDIA_BASE = 'https://content.rusiczki.net/microblog/twitter'

archive_path = ARGV[0]
abort "Usage: #{$PROGRAM_NAME} path/to/twitter-archive.zip" unless archive_path
abort "Archive not found: #{archive_path}" unless File.exist?(archive_path)

FileUtils.mkdir_p(ENTRIES_DIR)
FileUtils.mkdir_p(MEDIA_STAGING)

tmpdir = Dir.mktmpdir
at_exit { FileUtils.rm_rf(tmpdir) }

# Strip the `window.YTD.<thing>.partN = ` prefix Twitter wraps each data file in,
# leaving plain JSON behind.
def strip_js_prefix(raw)
  raw.sub(/\Awindow\.YTD\.[\w]+\.part\d+\s*=\s*/, '')
end

tweet_js_files = []
media_files    = {}
account_id     = nil
username       = nil

Zip::File.open(archive_path) do |zip|
  zip.each do |entry|
    case entry.name
    when %r{^data/tweets(?:-part\d+)?\.js$}
      target = File.join(tmpdir, File.basename(entry.name))
      entry.extract(target)
      tweet_js_files << target
    when %r{^data/tweets_media/(.+)$}
      filename = Regexp.last_match(1)
      target = File.join(tmpdir, 'media', filename)
      FileUtils.mkdir_p(File.dirname(target))
      entry.extract(target)
      media_files[filename] = target
    when 'data/account.js'
      target = File.join(tmpdir, 'account.js')
      entry.extract(target)
      data = JSON.parse(strip_js_prefix(File.read(target)))
      account_id = data.first.dig('account', 'accountId')
      username   = data.first.dig('account', 'username')
    end
  end
end

abort 'Could not find data/account.js in the archive' unless account_id && username
abort 'No tweets.js / tweets-part*.js found in the archive' if tweet_js_files.empty?

puts "Account: @#{username} (id=#{account_id})"
puts "Tweet data files: #{tweet_js_files.size}"
puts "Media files in archive: #{media_files.size}"

all_tweets = tweet_js_files.flat_map do |path|
  JSON.parse(strip_js_prefix(File.read(path))).map { |entry| entry['tweet'] }
end
puts "Total tweets in archive: #{all_tweets.size}"

def original?(tweet, my_id)
  return false if tweet['retweeted']
  return false if tweet['full_text'].to_s.start_with?('RT @')
  reply_to = tweet['in_reply_to_user_id_str']
  return false if reply_to && reply_to != my_id
  true
end

def expand_urls(text, urls)
  return text if urls.nil? || urls.empty?
  urls.each do |u|
    next unless u['url'] && u['expanded_url']
    text = text.gsub(u['url'], u['expanded_url'])
  end
  text
end

# Twitter HTML-escapes &, <, > inside full_text. Reverse for Markdown output.
def unescape_twitter(text)
  text.gsub('&amp;', '&').gsub('&lt;', '<').gsub('&gt;', '>')
end

kept           = 0
skipped        = 0
media_staged   = 0
media_missing  = 0

all_tweets.each do |tweet|
  unless original?(tweet, account_id)
    skipped += 1
    next
  end

  tweet_id   = tweet['id_str']
  created_at = Time.parse(tweet['created_at']).utc
  date_iso   = created_at.strftime('%Y-%m-%d')
  date_full  = created_at.strftime('%Y-%m-%d %H:%M:%S +0000')
  year       = created_at.strftime('%Y')

  body = tweet['full_text'].to_s.dup
  body = expand_urls(body, tweet.dig('entities', 'urls'))

  media = tweet.dig('extended_entities', 'media') || tweet.dig('entities', 'media') || []
  media_lines = []
  media.each do |m|
    src_url = m['media_url_https'] || m['media_url']
    next unless src_url

    basename         = File.basename(URI.parse(src_url).path)
    archive_filename = "#{tweet_id}-#{basename}"

    if media_files.key?(archive_filename)
      dest = File.join(MEDIA_STAGING, archive_filename)
      FileUtils.cp(media_files[archive_filename], dest) unless File.exist?(dest)
      public_url = "#{PUBLIC_MEDIA_BASE}/#{archive_filename}"
      alt = m['alt_text'].to_s
      media_lines << "![#{alt}](#{public_url})"
      body = body.gsub(m['url'], '') if m['url']
      media_staged += 1
    else
      media_missing += 1
      warn "  missing in archive: #{archive_filename}"
    end
  end

  body = unescape_twitter(body).strip
  body += "\n\n" + media_lines.join("\n\n") unless media_lines.empty?

  lang_value = tweet['lang'] == 'ro' ? 'ro' : 'en'

  out_dir  = File.join(ENTRIES_DIR, year)
  FileUtils.mkdir_p(out_dir)
  out_file = File.join(out_dir, "#{date_iso}-#{tweet_id}.md")

  File.open(out_file, 'w') do |f|
    f.puts '---'
    f.puts %(title: "Microblog #{created_at.strftime('%Y-%m-%d %H:%M UTC')}")
    f.puts "date: #{date_full}"
    f.puts 'source: twitter'
    f.puts %(source_id: "#{tweet_id}")
    f.puts "source_url: https://twitter.com/#{username}/status/#{tweet_id}"
    f.puts "lang: #{lang_value}"
    f.puts %(slug: "#{tweet_id}")
    f.puts '---'
    f.puts body
  end
  kept += 1
end

puts
puts "Kept:           #{kept}"
puts "Skipped:        #{skipped}"
puts "Media staged:   #{media_staged}"
puts "Media missing:  #{media_missing}"
puts
puts "Entries written under: #{ENTRIES_DIR}"
puts "Media staged under:    #{MEDIA_STAGING}"
puts
puts 'Next steps:'
puts '  1. Dry-run media upload (no writes):'
puts '       rsync -avzn _microblog_media_staging/twitter/ user@content-host:<content_root>/microblog/twitter/'
puts '  2. If the dry-run looks right, upload for real (no --delete, ever):'
puts '       rsync -avz  _microblog_media_staging/twitter/ user@content-host:<content_root>/microblog/twitter/'
puts '  3. Commit and push the markdown:'
puts "       git add _microblog/twitter && git commit -m 'Import Twitter archive' && git push"
