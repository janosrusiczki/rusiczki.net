require 'html-proofer'

task :test do
  # sh "bundle exec jekyll build"
  options = {
    assume_extension: true,
    disable_external: true,
    url_ignore: [
      '/feed/',
      /^\/assets/
    ],
    internal_domains: [
      'https://content.rusiczki.net'
    ]
  }
  HTMLProofer.check_directories(["./_site/#{Date.current.year}/", "./_site/#{Date.current.year - 1}/"], options).run
end