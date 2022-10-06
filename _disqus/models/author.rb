# frozen_string_literal: true

require 'nokogiri'

# Author PORO
class Author
  attr_reader :name, :is_anonymous, :username

  def initialize(element)
    @name = cofe(element, 'name')
    @is_anonymous = cofe(element, 'isAnonymous')
    @username = cofe(element, 'name')
  end
end
