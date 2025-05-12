require "json"

module RailsStats
  class JSONFormatter < StatsFormatter
    def result
      @result = []
      old_stdout = $stdout
      $stdout = StringIO.new
      Bundler::Stats::CLI.start(["-f", "json"])
      bundler_stats_cli_json_result = $stdout.string
      $stdout = old_stdout

      @result << JSON.parse(bundler_stats_cli_json_result) unless bundler_stats_cli_json_result.strip.empty?

      @result += @statistics.map { |key, stats| stat_hash(key, stats) }
      @result << stat_hash("Code", @code_total).merge(code_test_hash) if @code_total
      @result << stat_hash("Tests", @tests_total).merge(code_test_hash) if @tests_total
      @result << stat_hash("Total", @grand_total).merge(code_test_hash) if @grand_total

      @result << { "schema_stats" => schema_info }

      @result
    end

    def to_s
      puts JSON.generate(result, ascii_only: false)
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
          "files" => statistics.files_total.to_s,
          "lines" => statistics.lines.to_s,
          "loc" => statistics.code_lines.to_s,
          "classes" => statistics.classes.to_s,
          "methods" => statistics.methods.to_s,
          "m_over_c" => m_over_c.to_s,
          "loc_over_m" => loc_over_m.to_s
        }
      end

      def schema_info
        if File.exist?(calculator.schema_path)
          {
            "schema_stats" => calculator.schema,
            "create_table_calls" => calculator.create_table_calls
          }
        else
          { "schema_stats" => "No schema.rb file found" }
        end
      end
  end
end