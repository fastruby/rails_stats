module RailsStats
  class GemStatistics
    attr_reader :statistics, :total, :test

    def initialize(directory)
      @test = false
      @directory  = directory
      @statistics = calculate_statistics
      @total      = calculate_total
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
      # ignore gem/app so as to not double-count engines
      lib = File.join(@directory, "lib")
      Util.calculate_statistics([lib]) do |path|
        "Gems"
      end
    end
  end

end
