# railties/lib/rails/code_statistics.rb

module RailsStats
  class CodeStatistics
    def initialize(root_directory, opts = {})
      @calculator     = RailsStats::StatsCalculator.new(root_directory)
      @formatter      = load_formatter(opts)
    end

    def load_formatter(opts = {})
      if opts[:format] == "json"
        RailsStats::JSONFormatter.new(@calculator, opts)
      else
        RailsStats::ConsoleFormatter.new(@calculator, opts)
      end
    end

    def to_s
      @formatter.to_s
    end
  end
end
