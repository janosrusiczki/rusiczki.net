# {% year_utilities %}
# Returns a list of links to all years that have posts in them
#
# To install, copy this file into your Jekyll/Octopress plugins folder
# To use: {% year_utilities PARAMETER %}
#
# PARAMETER can be:
# 	year_links (returns a list of links to all years that have posts in them)

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
      years = all_posts.map { |post|
        puts post.date.strftime("%Y")
        post.date.strftime("%Y")
      }.uniq

      if @text.start_with? "year_links"
        years.map { |year| "<a href='/#{year}/' class='year-link'>#{year}</a>" }.join(', ')
      end

      return the_result
    end
  end
end

Liquid::Template.register_tag('year_utilities', Jekyll::YearUtilities)
