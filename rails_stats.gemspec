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
  spec.homepage      = "https://github.com/fastruby/rails_stats"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"
  spec.add_dependency "bundler-stats", ">= 2.1"
end
