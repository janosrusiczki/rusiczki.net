# {% year_utilities %}
# Returns a list of links to all years that have posts in them
#
# To install, copy this file into your Jekyll/Octopress plugins folder
# To use: {% year_utilities PARAMETER %}
#
# PARAMETER can be:
# 	year_links (returns a list of links to all years that have posts in them)
# 	years_with_month_links (returns a list of links to all years that have posts in them, with links to the months in each year)

module Jekyll
  class YearUtilities < Liquid::Tag
    def initialize(tag, text, tokens)
      super
      @tag = tag
      @text = text.strip
      @tokens = tokens
    end

    def render(context)
      the_result = nil

      all_posts = context.registers[:site].posts.docs
      years = all_posts.map { |post| post.date.strftime("%Y") }.uniq

      if @text.start_with? "year_links"
        the_result = years.map { |year| "<a href='/#{year}/' class='year-link'>#{year}</a>" }.join(', ')
      end

      if @text.start_with? "years_with_month_links"
        years_with_month_links = years.map do |year|
          year_with_month_links = "<a href='/#{year}/' class='year-link'>#{year}</a> ("
          year_with_month_links += months_in_year(all_posts, year).map { |month| "<a href='/#{year}/#{month}/' class='month-link'>#{Date::MONTHNAMES[month.to_i]}</a>" } .join(', ')
          year_with_month_links += ")"
          puts year_with_month_links
          return year_with_month_links
        end
        puts years_with_month_links
        the_result = years_with_month_links.join(', ')
      end

      return the_result
    end

    def months_in_year(posts, year)
      posts.select { |post| post.date.strftime("%Y") == year }.map { |post| post.date.strftime("%m") }.uniq
    end
  end
end

Liquid::Template.register_tag('year_utilities', Jekyll::YearUtilities)
