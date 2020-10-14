module RailsStats
  class ConsoleFormatter < StatsFormatter
    def to_s
      print_header
      @statistics.each { |key, stats| print_line(key, stats) }
      print_splitter

      if @total
        print_line("Total", @total)
        print_splitter
      end

      print_code_test_stats
    end

    private

      def print_header
        print_splitter
        puts "| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |"
        print_splitter
      end

      def print_splitter
        puts "+----------------------+-------+-------+---------+---------+-----+-------+"
      end

      def print_line(name, statistics)
        m_over_c   = (statistics.methods / statistics.classes) rescue m_over_c = 0
        loc_over_m = (statistics.code_lines / statistics.methods) - 2 rescue loc_over_m = 0

        puts "| #{name.ljust(20)} " \
            "| #{statistics.lines.to_s.rjust(5)} " \
            "| #{statistics.code_lines.to_s.rjust(5)} " \
            "| #{statistics.classes.to_s.rjust(7)} " \
            "| #{statistics.methods.to_s.rjust(7)} " \
            "| #{m_over_c.to_s.rjust(3)} " \
            "| #{loc_over_m.to_s.rjust(5)} |"
      end

      def print_code_test_stats
        code  = calculator.code_loc
        tests = calculator.test_loc

        puts "  Code LOC: #{code}     Test LOC: #{tests}     Code to Test Ratio: 1:#{sprintf("%.1f", tests.to_f/code)}"
        puts ""
      end
    end
end