require 'yaml'
Dir['_posts/*'].each do |path|
  puts '=================================='

  file = File.open(path, 'r')
  contents = file.read

  contents.gsub!(/\/blog\/archives\/(\d{4})\/(\d{2})\/(\d{2})\/([^\"]*)/) do |match|
    puts match
    year = $1
    month = $2
    day = $3
    slug = $4.gsub('_', '-')
    "/#{year}/#{month}/#{day}/#{slug}/"
  end

  file.reopen(path, 'w')
  file.write(contents)

  #puts contents
end
