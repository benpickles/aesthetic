# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aesthetic/version'

Gem::Specification.new do |spec|
  spec.name          = 'aesthetic'
  spec.version       = Aesthetic::VERSION
  spec.authors       = ['Ben Pickles']
  spec.email         = ['spideryoung@gmail.com']
  spec.summary       = %(Aesthetic is a tool to help you regression-test your site's aesthetic and ensure that tiny CSS changes don't have unintentional side effects in other areas of your site.)
  spec.description   = %(Aesthetic is a tool to help you regression-test your site's aesthetic and ensure that tiny CSS changes don't have unintentional side effects in other areas of your site. Using Aesthetic will give you the confidence to freely refactor your CSS from the ground up instead of building up layers of hacks that you'll find time to fix one day.)
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>=5'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
end
