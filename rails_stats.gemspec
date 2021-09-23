# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_stats"
  spec.version       = RailsStats::VERSION
  spec.authors       = ["Brian Leonard"]
  spec.email         = ["brian@bleonard.com"]
  spec.summary       = %q{Analyze a Rails project}
  spec.description   = %q{Point it to a directory and see stuff about the app}
  spec.homepage      = "https://github.com/bleonard/rails_stats"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_development_dependency "bundler", ">= 1.6", "< 3.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "codecov"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-around"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-console"
end
