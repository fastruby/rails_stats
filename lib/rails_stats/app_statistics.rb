require 'rails_stats/code_statistics_calculator'
require 'rails_stats/inflector'

module RailsStats
  class AppStatistics
    attr_reader :statistics
    attr_reader :total

    def initialize(app_directory)
      @app_directory = app_directory
      @statistics    = calculate_statistics
      @total         = calculate_total
    end

    private

    def calculate_directory_statistics(directory, pattern = /.*\.(rb|js|coffee|feature)$/)
      stats = CodeStatisticsCalculator.new

      Dir.foreach(directory) do |file_name|
        path = "#{directory}/#{file_name}"

        if File.directory?(path) && (/^\./ !~ file_name)
          stats.add(calculate_directory_statistics(path, pattern))
        end

        next unless file_name =~ pattern

        stats.add_by_file_path(path)
      end

      stats
    end

    def calculate_statistics
      out = {}
      directories.each do |dir_path|
        key = path_to_type(dir_path)
        out[key] ||= CodeStatisticsCalculator.new
        out[key].add(calculate_directory_statistics(dir_path))
      end

      out.keys.each do |key|
        out.delete(key) if out[key].lines == 0
      end
      out
    end

    def calculate_total
      out = CodeStatisticsCalculator.new
      @statistics.each do |key, stats|
        out.add(stats)
      end
      out
    end

    def directories
      out = []
      Dir.foreach(@app_directory) do |file_name|
        path = "#{@app_directory}/#{file_name}"
        next unless File.directory?(path)
        next if (/^\./ =~ file_name)

        # TODO: filter anything?
        out << path
      end
      out
    end

    def path_to_type(path)
      folder = File.basename(path)
      folder = Inflector.pluralize(folder)
      folder = Inflector.humanize(folder)
      folder = Inflector.titleize(folder)
      folder
    end
  end

end
