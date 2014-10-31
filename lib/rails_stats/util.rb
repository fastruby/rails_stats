module RailsStats
  module Util
    extend self

    def calculate_statistics(directories, &block)
      out = {}
      directories.each do |dir_path|
        key = nil
        if block_given?
          key = yield(dir_path)
        end

        key = path_to_name(dir_path) if !key || key.length == 0
        
        out[key] ||= CodeStatisticsCalculator.new
        out[key].add(calculate_directory_statistics(dir_path))
      end

      out.keys.each do |key|
        out.delete(key) if out[key].lines == 0
      end

      out
    end

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

    def path_to_name(path)
      folder = File.basename(path)
      folder = Inflector.pluralize(folder)
      folder = Inflector.humanize(folder)
      folder = Inflector.titleize(folder)
      folder
    end
  end
end
