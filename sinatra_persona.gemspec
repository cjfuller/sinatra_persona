# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra_persona/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra_persona"
  spec.version       = SinatraPersona::VERSION
  spec.authors       = ["Colin J. Fuller"]
  spec.email         = ["cjfuller@gmail.com"]
  spec.summary       = %q{Persona verifier for Sinatra}
  spec.homepage      = "https://github.com/cjfuller/sinatra_persona"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "haml"
  spec.add_dependency "sinatra"
end


