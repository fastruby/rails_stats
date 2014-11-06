# railties/lib/rails/tasks/statistics.rake

module RailsStats
  module Rake
    def calculate(root_directory)
      puts "\nDirectory: #{File.absolute_path(root_directory)}\n\n"
      CodeStatistics.new(root_directory).to_s
    end
  end
end
