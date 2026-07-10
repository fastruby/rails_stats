require "bundler/stats/cli"

module RailsStats
  class ConsoleFormatter < StatsFormatter
    def to_s
      Bundler::Stats::CLI.start(['--format', 'text'])

      if calculator.packs?
        print_grouped
      else
        print_flat
      end

      print_code_test_stats
      print_polymorphic_stats
      print_schema_stats
    end

    private

      def print_flat
        print_table(@statistics)
      end

      def print_grouped
        @statistics_by_group.each do |group, group_statistics|
          puts "== #{group_label(group)} =="
          print_table(group_statistics)
          puts ""
        end

        puts "== #{grand_total_label} =="
        print_table(@statistics)
      end

      def group_label(group)
        group == RailsStats::StatsCalculator::CORE_GROUP ? "Core Application" : "Pack: #{group}"
      end

      def grand_total_label
        "Total (all packs)"
      end

      # Prints a full table (header, one line per concept, and Code/Tests/Total
      # totals) for the given {concept => CodeStatisticsCalculator} hash.
      def print_table(statistics)
        code, tests, grand = calculator.totals_for(statistics)

        print_header
        statistics.keys.sort.each { |key| print_line(key, statistics[key]) }
        print_splitter

        print_line("Code", code)
        print_line("Tests", tests)
        print_line("Total", grand)
        print_splitter
      end

      def print_header
        print_splitter
        puts "| Name                 | Files   | Lines   |     LOC | Classes | Methods | M/C | LOC/M |"
        print_splitter
      end

      def print_splitter
        puts "+----------------------+---------+---------+---------+---------+---------+-----+-------+"
      end

      def print_line(name, statistics)
        m_over_c   = (statistics.methods / statistics.classes) rescue m_over_c = 0
        loc_over_m = (statistics.code_lines / statistics.methods) - 2 rescue loc_over_m = 0

        puts "| #{name.ljust(20)} " \
            "| #{statistics.files_total.to_s.rjust(7)} " \
            "| #{statistics.lines.to_s.rjust(7)} " \
            "| #{statistics.code_lines.to_s.rjust(7)} " \
            "| #{statistics.classes.to_s.rjust(7)} " \
            "| #{statistics.methods.to_s.rjust(7)} " \
            "| #{m_over_c.to_s.rjust(3)} " \
            "| #{loc_over_m.to_s.rjust(5)} |"
      end

      def print_code_test_stats
        code  = calculator.code_loc
        tests = calculator.test_loc

        puts "  Code LOC: #{code}     Test LOC: #{tests}     Code to Test Ratio: 1:#{sprintf("%.1f", tests.to_f/code)}  Files: #{calculator.files_total}"
        puts ""
      end

      def print_polymorphic_stats
        puts "  Polymorphic models count: #{calculator.polymorphic} polymorphic associations"
      end

      def print_schema_stats
        if File.exist?(calculator.schema_path)
          puts "  Schema Stats: #{calculator.schema} `create_table` calls in schema.rb"
        elsif File.exist?(calculator.structure_path)
          puts "  Schema Stats: #{calculator.schema} `CREATE TABLE` calls in structure.sql"
        else
          puts "  Schema Stats: No schema.rb or structure.sql file found"
        end
      end
  end
end
