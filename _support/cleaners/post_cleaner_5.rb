require 'yaml'
# Get a list of all the files in the _posts directory (excluding directories)
posts = Dir.glob("_posts/*").select { |f| File.file? f }

Dir.glob('_posts/**/*').select { |f| File.file? f }.each do |path|
  puts '=================================='

  file = File.open(path, 'r')
  contents = file.read

  # Get the YAML front matter
  front_matter = contents.match(/---(.*)---/m)[1]

  # Parse the YAML front matter
  front_matter = YAML.load(front_matter)

  # Get the categories from the front matter and replace them with downcased versions
  front_matter['categories'] = front_matter['categories'].map(&:downcase)

  # Replace the YAML front matter with the new front matter
  contents = contents.gsub(/---(.*)---/m, front_matter.to_yaml + '---')

  file.reopen(path, 'w')
  file.write(contents)

  puts contents
end
