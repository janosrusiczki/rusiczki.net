require 'yaml'
Dir['_posts/*'].each do |path|
  puts '=================================='

  file = File.open(path, 'r')
  contents = file.read

  contents.gsub!(/\<br \/\>\n/, "\n\n")
  contents.gsub!(/\<\/p\>\n/, "\n\n")
  contents.gsub!(/\<p\>/, '')
  contents.gsub!(/(\n*)/, "\n")

  file.reopen(path, 'w')
  file.write(contents)

  puts contents
end
