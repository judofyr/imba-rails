# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imba/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "imba-rails"
  spec.version       = Imba::Rails::VERSION
  spec.authors       = ["Magnus Holm"]
  spec.email         = ["judofyr@gmail.com"]

  spec.summary       = %q{Rails integration for Imba}
  spec.homepage      = "https://github.com/judofyr/imba-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|example_app)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 4.2.0"
  spec.add_dependency "imba-template"
  spec.add_dependency "imba-source"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
