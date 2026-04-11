# {% site_stats <param> %}
# Outputs computed statistics about the site for use in pages like /about.
# Absorbed the older posts_word_count plugin: total_words / average_words /
# longest_post_words / longest_post_title preserve its functionality.
#
# Supported params:
#   total_words              - sum of words across all posts (formatted)
#   average_words            - total / post count (formatted)
#   longest_post_words       - word count of the longest post (formatted)
#   longest_post_title       - title of the longest post
#   years_online             - current year minus first-post year
#   most_prolific_year       - year with the most posts
#   most_prolific_year_count - post count for that year (formatted)
#   reading_hours            - total_words / 200 / 60, one decimal
#   silent_years             - comma-joined list of years with zero posts
#   longest_posts            - markdown numbered list, top 5 by word count
#   top_months               - markdown numbered list, top 5 most prolific months
#   longest_gaps             - markdown numbered list, top 5 longest gaps between posts
#   top_categories           - markdown numbered list, top 5 most-used categories
#
# Stats are computed once per build and memoized by site.object_id.

module Jekyll
  class SiteStatistics < Liquid::Tag
    # Language tags that are used as categories on this blog. Excluded from
    # the top_categories list because they describe language, not topic, and
    # would otherwise dominate the ranking.
    LANGUAGE_CATEGORIES = %w[english romanian română romana hungarian magyar].freeze

    @@cache = {}

    def initialize(tag, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      site = context.registers[:site]
      stats = compute(site)

      case @text
      when "total_words"              then format_number(stats[:total_words])
      when "average_words"            then format_number(stats[:average_words])
      when "longest_post_words"       then format_number(stats[:longest_post_words])
      when "longest_post_title"       then stats[:longest_post_title]
      when "years_online"             then stats[:years_online].to_s
      when "most_prolific_year"       then stats[:most_prolific_year].to_s
      when "most_prolific_year_count" then format_number(stats[:most_prolific_year_count])
      when "reading_hours"            then "%.1f" % stats[:reading_hours]
      when "silent_years"             then stats[:silent_years].join(", ")
      when "longest_posts"            then stats[:longest_posts_md]
      when "top_months"               then stats[:top_months_md]
      when "longest_gaps"             then stats[:longest_gaps_md]
      when "top_categories"           then stats[:top_categories_md]
      else "[unknown site_stats param: #{@text}]"
      end
    end

    private

    def compute(site)
      cached = @@cache[site.object_id]
      return cached if cached

      posts = site.posts.docs

      total_words = 0
      longest_words = 0
      longest_title = ""
      year_counts = Hash.new(0)
      month_counts = Hash.new(0)
      category_counts = Hash.new(0)
      post_infos = []

      posts.each do |post|
        words = word_count(post.content)
        total_words += words

        if words > longest_words
          longest_words = words
          longest_title = post.data["title"].to_s
        end

        year_counts[post.date.year] += 1
        month_counts[post.date.strftime("%Y-%m")] += 1

        cats = post.data["categories"]
        if cats.is_a?(Array)
          cats.each { |c| category_counts[c.to_s] += 1 unless c.to_s.empty? }
        elsif cats.is_a?(String) && !cats.empty?
          cats.split(/\s+/).each { |c| category_counts[c] += 1 }
        end

        post_infos << {
          title: post.data["title"].to_s,
          url: post.url,
          words: words,
          date: post.date
        }
      end

      post_count = posts.size
      average = post_count.zero? ? 0 : (total_words / post_count)

      first_year = year_counts.keys.min
      current_year = Time.now.year
      years_online = current_year - first_year

      most_year, most_year_count = year_counts.max_by { |_, c| c }

      silent = (first_year..current_year).reject { |y| year_counts.key?(y) }

      result = {
        total_words: total_words,
        average_words: average,
        longest_post_words: longest_words,
        longest_post_title: longest_title,
        years_online: years_online,
        most_prolific_year: most_year,
        most_prolific_year_count: most_year_count,
        reading_hours: total_words.to_f / 200.0 / 60.0,
        silent_years: silent,
        longest_posts_md: build_longest_posts_md(post_infos),
        top_months_md: build_top_months_md(month_counts),
        longest_gaps_md: build_longest_gaps_md(post_infos),
        top_categories_md: build_top_categories_md(category_counts)
      }

      @@cache[site.object_id] = result
      result
    end

    def build_longest_posts_md(post_infos)
      post_infos.sort_by { |p| -p[:words] }.first(5).each_with_index.map { |p, i|
        "#{i + 1}. [#{p[:title]}](#{p[:url]}) — #{format_number(p[:words])} words"
      }.join("\n")
    end

    def build_top_months_md(month_counts)
      month_counts.sort_by { |_, c| -c }.first(5).each_with_index.map { |(ym, count), i|
        year, month = ym.split("-")
        label = "#{Date::MONTHNAMES[month.to_i]} #{year}"
        "#{i + 1}. [#{label}](/#{year}/#{month}/) — #{count} posts"
      }.join("\n")
    end

    def build_longest_gaps_md(post_infos)
      sorted = post_infos.sort_by { |p| p[:date] }
      gaps = []
      sorted.each_cons(2) do |earlier, later|
        days = ((later[:date] - earlier[:date]) / 86400.0).to_i
        gaps << { days: days, earlier: earlier, later: later }
      end
      gaps.sort_by { |g| -g[:days] }.first(5).each_with_index.map { |g, i|
        "#{i + 1}. **#{format_number(g[:days])} days** between [#{g[:earlier][:title]}](#{g[:earlier][:url]}) and [#{g[:later][:title]}](#{g[:later][:url]})"
      }.join("\n")
    end

    def build_top_categories_md(category_counts)
      filtered = category_counts.reject { |name, _| LANGUAGE_CATEGORIES.include?(name.to_s.downcase) }
      filtered.sort_by { |_, c| -c }.first(5).each_with_index.map { |(name, count), i|
        slug = Jekyll::Utils.slugify(name)
        "#{i + 1}. [#{name}](/category/#{slug}/) — #{count} posts"
      }.join("\n")
    end

    def word_count(string)
      string.scan(/\S+/).count
    end

    def format_number(n)
      n.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end
end

Liquid::Template.register_tag('site_stats', Jekyll::SiteStatistics)
