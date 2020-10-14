module RailsStats
  class StatsFormatter
    def initialize(calculator, opts = {})
      @calculator = calculator
      @statistics = calculator.statistics
      @total      = calculator.total
    end

    attr_reader :calculator
  end
end