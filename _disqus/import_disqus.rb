# frozen_string_literal: true

require 'pry'
require './nokogiri_helper'

Dir[File.join(__dir__, 'models', '*.rb')].sort.each { |file| require file }

doc = Nokogiri::XML(File.open('kitsched-2021-12-14T11_01_05.483067-all.xml'))

threads = []

xml_threads = doc.css('disqus>thread')
xml_threads.each do |t|
  thr = DisqusThread.new(t)
  threads << thr
end

posts = []

xml_posts = doc.css('post')
puts "XML <post>s size is #{xml_posts.size}"

xml_posts.each do |p|
  post = Post.new(p)
  thread_dsq_id = p.css('thread').first['dsq:id']
  thread = threads.find { |t| t.dsq_id == thread_dsq_id }
  post.thread = thread
  thread.posts << post
  posts << post if post.is_spam == 'false' && post.is_deleted == 'false'
end

# post.parent =

puts "Visible posts size is #{posts.size}"
pry
