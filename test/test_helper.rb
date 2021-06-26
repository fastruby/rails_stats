# frozen_string_literal: true

if ENV["COVERAGE"] == "true"
  require "simplecov"
  require "simplecov-console"
  # require "codecov"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
    # SimpleCov::Formatter::Codecov,
  ]

  SimpleCov.start do
    track_files "lib/**/*.rb"
  end

  puts "Using SimpleCov v#{SimpleCov::VERSION}"
end

require "byebug"

require "minitest/autorun"
require "minitest/pride"
require "minitest/around/spec"

require "rails_stats/all"
