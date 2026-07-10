desc "Report code statistics (KLOCs, etc) from the current (or given) application"
task :stats, [:path, :format] do |t, args|
  Rake::Task["stats"].clear # clear out normal one if there
  require 'rails_stats/all'

  # Respect an explicitly given path even when running inside a booted Rails
  # app. Only fall back to Rails.root when no path was provided. This is what
  # makes `rake stats[packs/pack1]` work from inside the app (see issue #23).
  path = args[:path]
  path ||= Rails.root.to_s if defined?(Rails)
  fmt = args[:format] || ""
  raise "no path given for stats" unless path

  root_directory = File.absolute_path(path)
  puts "\nDirectory: #{root_directory}\n\n" if args[:path]
  RailsStats::CodeStatistics.new(root_directory, format: fmt).to_s
end