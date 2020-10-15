# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rails_stats"

Rake::TestTask.new do |task|
  task.libs.push "lib"
  task.libs.push "test"
  task.pattern = "test/**/*_test.rb"
end

task default: %i[test]
