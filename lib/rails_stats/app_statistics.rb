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
  end

end
