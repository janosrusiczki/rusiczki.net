# frozen_string_literal: true

require 'nokogiri'

# Post PORO
class Post
  attr_reader :id, :message, :created_at, :is_deleted, :is_spam, :author, :dsq_id
  attr_accessor :thread, :parent

  def initialize(element)
    @id = cofe(element, 'id')
    @message = cofe(element, 'message')
    @created_at = cofe(element, 'createdAt')
    @is_deleted = cofe(element, 'isDeleted')
    @is_spam = cofe(element, 'isSpam')
    @author = Author.new(element.css('author').first)
    @dsq_id = element['dsq:id']
  end
end
