# frozen_string_literal: true

require 'nokogiri'

# content of first element
def cofe(element, selector)
  element.css(selector).first.content
end
