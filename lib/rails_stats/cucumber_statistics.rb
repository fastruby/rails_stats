module RailsStats
  class CucumberStatistics
    attr_reader :statistics, :total, :test

    def initialize(directory)
      @test = true
      @directory    = directory
      @statistics   = calculate_statistics
      @total        = calculate_total
    end

    private

    def calculate_total
      out = CodeStatisticsCalculator.new(true)
      @statistics.each do |key, stats|
        out.add(stats)
      end
      out
    end

    def calculate_statistics
      out = {}
      categorize_files.each do |key, list|
        out[key] = Util.calculate_file_statistics(list)
      end 
      out
    end

    def categorize_files
      out = {}
      Dir[File.join(@directory, "**", "*.rb")].each do |file_path|
        out["Cucumber Support"] ||= []
        out["Cucumber Support"]  << file_path
      end

      Dir[File.join(@directory, "**", "*.feature")].each do |file_path|
        out["Cucumber Features"] ||= []
        out["Cucumber Features"]  << file_path
      end

      out
    end
  end

end
