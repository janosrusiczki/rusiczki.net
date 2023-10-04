# {% year_utilities %}
# Returns a list of links to all years that have posts in them
#
# To install, copy this file into your Jekyll/Octopress plugins folder
# To use: {% year_utilities PARAMETER %}
#
# PARAMETER can be:
# 	year_links (returns a list of links to all years that have posts in them)
# 	years_with_month_links (returns a list of links to all years that have posts in them, with links to the months in each year)
# 	next_year_link <year> - eg. {% year_utilities next_year_link variable_that_holds_the_current_year %} (returns a link to the next year that has posts in it)
# 	previous_year_link <year> - eg. {% year_utilities previous_year_link variable_that_holds_the_current_year %} (returns a link to the previous year that has posts in it)

module Jekyll
  class UtilitiesBase < Liquid::Tag
    def initialize(tag, text, tokens)
      super
      @tag = tag
      @text = text.strip
      @tokens = tokens
    end

    def all_posts
      @context.registers[:site].posts.docs
    end
  end

  class YearUtilities < UtilitiesBase
    def render(context)
      @context = context

      the_result = nil

      years = all_posts.map { |post| post.date.strftime("%Y") }.uniq

      if @text.start_with? "year_links"
        the_result = years.map { |year| "<a href='/#{year}/' class='year-link'>#{year}</a>" }.join(', ')
      end

      if @text.start_with? "years_with_month_links"
        years_with_month_links = "<ul class='year-list'>"
        years_with_month_links += years.map { |year| "<li><a href='/#{year}/' class='year-link'>#{year}</a>#{months_in_year_list(all_posts, year)}</li>" }.join
        years_with_month_links += "</ul>"
        the_result = years_with_month_links
      end

      if @text.start_with? "previous_year_link"
        current_year = context[@text.split(" ")[1].strip]
        previous_year_index = years.index(current_year) - 1
        if previous_year_index > -1
          previous_year = years[previous_year_index]
          the_result = "<a href='/#{previous_year}/' class='previous-year-link'>#{previous_year}</a>" if previous_year
        end
      end

      if @text.start_with? "next_year_link"
        current_year = context[@text.split(" ")[1].strip]
        next_year = years[years.index(current_year) + 1]
        the_result = "<a href='/#{next_year}/' class='next-year-link'>#{next_year}</a>" if next_year
      end

      return the_result
    end

    def months_in_year_list(posts, year)
      "<ul class='month-list'>" +
        months_in_year_array(posts, year).map { |month| "<li><a href='/#{year}/#{month}/' class='month-link'>#{Date::MONTHNAMES[month.to_i]}</a></li>" } .join +
        "</ul>"
    end

    def months_in_year_array(posts, year)
      posts.select { |post| post.date.strftime("%Y") == year }.map { |post| post.date.strftime("%m") }.uniq
    end
  end

  class CategoryUtilities < UtilitiesBase
    def render(context)
      @context = context

      categories = all_posts.map { |post| post.categories }.flatten.uniq

      if @text.start_with? "category_links"
        categories.map { |category| "<a href='/category/#{category}/' class='category-link'>#{category}</a>" }.join(', ')
      end
    end
  end
end

Liquid::Template.register_tag('year_utilities', Jekyll::YearUtilities)
Liquid::Template.register_tag('category_utilities', Jekyll::CategoryUtilities)
