Jekyll::Hooks.register :posts, :pre_render do |post|
  if post.data['excerpt_separator'].nil? && post.content =~ /^(<!--\s*more\s*-->)$/
    post.data['excerpt_separator'] = $1
    post.data['excerpt'] = Jekyll::Excerpt.new(post)
  end
end
