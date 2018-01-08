require 'yaml'
Dir['_posts/*'].each do |path|
  puts '=================================='

  file = File.open(path, 'r')
  contents = file.read

  contents.gsub!(/http\:\/\/www\.rusiczki\.net\/blog\/blogstuff/, 'https://content.rusiczki.net/blogstuff')
  contents.gsub!(/http\:\/\/www\.rusiczki\.net\/blog\/blogpics/, 'https://content.rusiczki.net/blogpics')
  contents.gsub!(/http\:\/\/www\.rusiczki\.net\/wp-content\/uploads/, 'https://content.rusiczki.net')

  file.reopen(path, 'w')
  file.write(contents)

  puts contents
end
