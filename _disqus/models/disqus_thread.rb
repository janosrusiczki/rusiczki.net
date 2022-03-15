# frozen_string_literal: true

require 'nokogiri'

# Thread PORO
class DisqusThread
  attr_reader :id, :forum, :category, :link, :title, :message, :created_at, :author, :is_closed, :is_deleted, :dsq_id
  attr_accessor :posts

  def initialize(element)
    @id = cofe(element, 'id')
    @forum = cofe(element, 'forum')
    # category
    @link = cofe(element, 'link')
    @title = cofe(element, 'title')
    @message = cofe(element, 'message')
    @created_at = cofe(element, 'createdAt')
    @author = Author.new(element.css('author').first)
    @is_closed = cofe(element, 'isClosed')
    @is_deleted = cofe(element, 'isDeleted')
    @dsq_id = element['dsq:id']
    @posts = []
  end
end
