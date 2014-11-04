module RailsStats
  class RootStatistics
    attr_reader :statistics, :total, :test

    ROOT_FOLDERS = {
      "lib" => "Libraries",
      "config" => "Configuration"
    }

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
      Util.calculate_statistics(directories) do |folder|
        ROOT_FOLDERS[File.basename(folder)]
      end
    end

    def directories
      out = []
      ROOT_FOLDERS.each do |folder, name|
        out << File.join(@directory, folder)
      end
      out
    end
  end

end
