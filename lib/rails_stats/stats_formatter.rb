module RailsStats
  class StatsFormatter
    def initialize(calculator, opts = {})
      @calculator  = calculator
      @statistics  = calculator.statistics
      @statistics_by_group = calculator.statistics_by_group
      @code_total  = calculator.code_total
      @tests_total = calculator.tests_total
      @grand_total = calculator.grand_total
    end

    attr_reader :calculator
  end
end