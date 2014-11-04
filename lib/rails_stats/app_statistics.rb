module RailsStats
  class AppStatistics
    attr_reader :statistics, :total, :test

    def initialize(directory)
      @test = false
      @directory  = directory
      @statistics = calculate_statistics
      @total      = calculate_total
    end

    def key_concepts
      directories.collect{ |path| File.basename(path) }
    end

    private

    def calculate_total
      out = CodeStatisticsCalculator.new
      @statistics.each do |key, stats|
        out.add(stats)
      end
      out
    end

    def calculate_statistics
      Util.calculate_statistics(directories)
    end

    def directories
      return @directories if @directories
      out = []
      Dir.foreach(@directory) do |file_name|
        path = File.join(@directory, file_name)
        next unless File.directory?(path)
        next if (/^\./ =~ file_name)
        next if file_name == "assets" # doing separately
        next if file_name == "views"  # TODO
        out << path
      end

      assets = File.join(@directory, "assets")
      if File.directory?(assets)
        Dir.foreach(assets) do |file_name|
          path = File.join(assets, file_name)
          next unless File.directory?(path)
          next if (/^\./ =~ file_name)

          case file_name
          when "javascripts"
            out << path
          # TODO when "css"
          end
        end
      end

      out
    end
  end

end
