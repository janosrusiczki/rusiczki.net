# -*- encoding: utf-8 -*-
# stub: jekyll_asset_pipeline 0.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll_asset_pipeline".freeze
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Matt Hodan".freeze, "Janos Rusiczki".freeze]
  s.date = "2019-10-16"
  s.description = "    Jekyll Asset Pipeline adds asset preprocessing (CoffeeScript, Sass,\n    Less, ERB, etc.) and asset compression / minification / gzip (Yahoo YUI\n    Compressor, Google Closure Compiler, etc.) to Jekyll.\n".freeze
  s.email = ["matthew.c.hodan@gmail.com".freeze, "janos.rusiczki@gmail.com".freeze]
  s.homepage = "https://github.com/matthodan/jekyll-asset-pipeline".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "A powerful asset pipeline for Jekyll that bundles, converts, and minifies CSS and JavaScript assets.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<jekyll>.freeze, [">= 3.5", "< 5.0"])
  s.add_runtime_dependency(%q<liquid>.freeze, ["~> 4.0"])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.2"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
end
