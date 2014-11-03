module RailsStats
  module Util
    extend self

    def calculate_projects(*args)
      projects = {}

      children = [args.pop].flatten
      parent   = args.flatten
      children.each do |dirname|
        child_folder_pattern = File.join(*(parent.dup + [dirname]))
        Dir[child_folder_pattern].each do |marker_path|
          next unless File.directory?(marker_path)

          # TODO: ignore vendor?

          projects[File.absolute_path(File.dirname(marker_path))] = true
        end
      end

      out = projects.keys

      # TODO: make sure none are children of other ones in there
      out
    end

    def calculate_statistics(directories, type = :code, &block)
      out = {}

      is_test = type.to_s == "test"

      directories.each do |dir_path|
        key = nil
        if block_given?
          key = yield(dir_path)
        end

        key = path_to_name(dir_path, is_test) if !key || key.length == 0
        
        out[key] ||= CodeStatisticsCalculator.new(is_test)
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

    def path_to_name(path, is_test)
      folder = File.basename(path)
      folder = Inflector.humanize(folder)
      folder = Inflector.titleize(folder)

      if is_test
        folder = Inflector.singularize(folder)
        folder = "#{folder} Tests"
      else
        folder = Inflector.pluralize(folder)
      end

      folder
    end
  end
end
