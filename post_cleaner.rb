require 'yaml'
Dir['_posts/*'].each do |path|
  puts '=================================='

  file = File.open(path, 'r')
  contents = file.read

  contents.gsub!(/(comments\:.*)(\-\-\-)/m, '\2')
  contents.gsub!(/tags\:.*\n/, '')
  contents.gsub!(/status\:.*\n/, '')
  contents.gsub!(/published\:.*\n/, '')
  contents.gsub!(/author\:.*\n/, '')
  contents.gsub!(/wordpress_id\:.*\n/, '')
  contents.gsub!(/wordpress_url\:.*\n/, '')
  contents.gsub!(/date_gmt\:.*\n.*\=\=\n/, '')

  if date = /date\:.*\n.*\=\=/.match(contents)
    publish_date = YAML.load(date[0])['date']
    contents.gsub!(/date\:.*\n.*\=\=/, 'date: ' + publish_date)
  end

  puts contents
end
