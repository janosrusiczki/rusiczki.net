require 'html-proofer'

task :test do
  options = {
    disable_external: true,
    enforce_https: false,
    ignore_urls: [
      '/feed/'
    ]
  }
  HTMLProofer.check_directory("./_site/", options).run
end
