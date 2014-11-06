require "rails_stats"

desc "Calculates the statistsics for a given Rails project"
task :stats, [:path] do |t, args|
  root_directory = File.absolute_path(args[:path])
  puts "\nDirectory: #{root_directory}\n\n"
  RailsStats::CodeStatistics.new(root_directory).to_s
end