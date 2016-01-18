# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'everything/version'

Gem::Specification.new do |spec|
  spec.name          = 'everything-core'
  spec.version       = Everything::VERSION
  spec.authors       = ['Kyle Tolle']
  spec.email         = ['kyle@nullsix.com']
  spec.summary       = %q{Library for working with your `everything` repository.}
  spec.description   = %q{Gives you access to pieces within your everything repo.}
  spec.homepage      = 'https://github.com/kyletolle/everything-core'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'dotenv', '= 2.0.2'
  spec.add_runtime_dependency 'fastenv', '= 0.0.2'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'rspec', '~> 3.4'
end

