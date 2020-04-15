require_relative 'lib/everything/version'

Gem::Specification.new do |spec|
  spec.name          = 'everything-core'
  spec.version       = Everything::VERSION
  spec.authors       = ['Kyle Tolle']
  spec.email         = ['kyle@nullsix.com']
  spec.summary       = %q{Library for working with your `everything` repository.}
  spec.description   = %q{Gives you access to pieces within your everything repo.}
  spec.homepage      = 'https://github.com/kyletolle/everything-core'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.1")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'dotenv', '~> 2.1'
  spec.add_runtime_dependency 'fastenv', '= 0.0.3'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.4'
end

