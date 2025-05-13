require "json"

module RailsStats
  class JSONFormatter < StatsFormatter
    def result
      @result = @statistics.map { |key, stats| stat_hash(key, stats) }

      if @grand_total
        @result << stat_hash("Total", @grand_total).merge(code_test_hash)
      end

      @result << { "schema_stats" => schema_info }
      @result << { "sti_stats" => print_sti_stat }
      @result << { "polymorphic_stats" => print_polymorphic_stats }

      @result
    end

    def to_s
      puts result.to_json
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

      def print_sti_stat
        if calculator.sti
          {
            "sti_models_count" => calculator.sti,
          }
        end
      end

      def print_polymorphic_stats
        if calculator.polymorphic
          {
            "polymorphic_models_count" => calculator.polymorphic,
          }
        end
      end

      def schema_info
        if File.exist?(calculator.schema_path)
          {
            "schema_path" => calculator.schema_path,
            "create_table calls count" => calculator.schema,
          }
        elsif File.exist?(calculator.structure_path)
          {
            "structure_path" => calculator.structure_path,
            "create_table calls count" => calculator.schema
          }
        else
          { "schema_stats" => "No schema.rb or structure.sql file found" }
        end
      end
  end
end