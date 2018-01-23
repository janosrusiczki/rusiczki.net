require 'html-proofer'

task :test do
  options = {
    disable_external: true,
    url_ignore: [
      '/feed/'
    ]
  }
  HTMLProofer.check_directory("./_site/", options).run
end
