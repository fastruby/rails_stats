require "json"

module RailsStats
  class JSONFormatter < StatsFormatter
    def to_s
      @result = @statistics.map { |key, stats| stat_hash(key, stats) }

      if @total
        @result << stat_hash("Total", @total).merge(code_test_hash)
      end

      puts @result.to_json
    end

    private

      def code_test_hash
        code  = calculator.code_loc
        tests = calculator.test_loc

        {
          "code_to_test_ratio" => "#{sprintf("%.1f", tests.to_f/code)}", "total" => true
        }
      end

      def stat_hash(name, statistics)
        m_over_c   = (statistics.methods / statistics.classes) rescue m_over_c = 0
        loc_over_m = (statistics.code_lines / statistics.methods) - 2 rescue loc_over_m = 0

        {
          "name" => name,
          "lines" => statistics.lines.to_s,
          "loc" => statistics.code_lines.to_s,
          "classes" => statistics.classes.to_s,
          "methods" => statistics.methods.to_s,
          "m_over_c" => m_over_c.to_s,
          "loc_over_m" => loc_over_m.to_s
        }
      end
  end
end
