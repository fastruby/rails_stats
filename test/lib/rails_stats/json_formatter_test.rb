# frozen_string_literal: true

require "test_helper"

describe RailsStats::JSONFormatter do
  describe "#result" do
    def code_stat(name, files:, lines:, loc:, classes:, methods: "0", m_over_c: "0", loc_over_m: "0")
      {"name"=>name, "files"=>files, "lines"=>lines, "loc"=>loc,
       "classes"=>classes, "methods"=>methods, "m_over_c"=>m_over_c, "loc_over_m"=>loc_over_m}
    end

    def total_stat(name, files:, lines:, loc:, classes:, methods: "0", m_over_c: "0", loc_over_m: "0", code_to_test_ratio: "0.0")
      code_stat(name, files: files, lines: lines, loc: loc, classes: classes,
                methods: methods, m_over_c: m_over_c, loc_over_m: loc_over_m)
        .merge("code_to_test_ratio" => code_to_test_ratio, "total" => true)
    end

    EXPECTED_GEM_NAMES = %w[
      simplecov-console codecov rails_stats simplecov minitest-around
      bundler byebug minitest minitest-spec-context
    ].freeze

    it "outputs useful stats for a Rails project" do
      root_directory = File.absolute_path("./test/dummy")

      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::JSONFormatter.new(calculator)
      result = formatter.result

      # Verify bundler-stats structure (without asserting on version-specific values)
      gems_section = result.find { |h| h["gems"] }
      assert gems_section, "Expected a gems section in the result"
      assert gems_section["summary"], "Expected a summary in the gems section"
      %w[declared unpinned total github].each do |key|
        assert gems_section["summary"].key?(key), "Expected summary to have '#{key}'"
      end

      gem_names = gems_section["gems"].map { |g| g["name"] }
      assert_equal EXPECTED_GEM_NAMES.sort, gem_names.sort

      gems_section["gems"].each do |gem|
        %w[name total_dependencies first_level_dependencies top_level_dependencies transitive_dependencies].each do |key|
          assert gem.key?(key), "Expected gem '#{gem["name"]}' to have '#{key}'"
        end
      end

      # Verify code stats (these are stable across Ruby versions)
      expected_code_stats = [
        code_stat("Mailers",       files: "1",  lines: "4",   loc: "4",   classes: "1"),
        code_stat("Models",        files: "4",  lines: "10",  loc: "10",  classes: "4"),
        code_stat("Controllers",   files: "1",  lines: "7",   loc: "6",   classes: "1", methods: "1", m_over_c: "1", loc_over_m: "4"),
        code_stat("Helpers",       files: "1",  lines: "3",   loc: "3",   classes: "0"),
        code_stat("Jobs",          files: "1",  lines: "7",   loc: "2",   classes: "1"),
        code_stat("Channels",      files: "2",  lines: "8",   loc: "8",   classes: "2"),
        code_stat("Javascripts",   files: "6",  lines: "28",  loc: "7",   classes: "0"),
        code_stat("Libraries",     files: "1",  lines: "1",   loc: "1",   classes: "0"),
        code_stat("Configuration", files: "19", lines: "417", loc: "111", classes: "1"),
        code_stat("Model Tests",   files: "2",  lines: "5",   loc: "4",   classes: "2"),
        code_stat("Spec Support",  files: "1",  lines: "1",   loc: "1",   classes: "0"),
        code_stat("Test Support",  files: "1",  lines: "1",   loc: "1",   classes: "0"),
      ]

      code_stats = result.select { |h| h["name"] && !h["total"] }
      assert_equal expected_code_stats.sort_by { |h| h["name"] }, code_stats.sort_by { |h| h["name"] }

      # Verify totals
      expected_totals = [
        total_stat("Code",  files: "36", lines: "485", loc: "152", classes: "10", methods: "1", loc_over_m: "150"),
        total_stat("Tests", files: "4",  lines: "7",   loc: "6",   classes: "2"),
        total_stat("Total", files: "40", lines: "492", loc: "158", classes: "12", methods: "1", loc_over_m: "156"),
      ]

      totals = result.select { |h| h["total"] }
      assert_equal expected_totals.sort_by { |h| h["name"] }, totals.sort_by { |h| h["name"] }

      # Verify schema and polymorphic stats
      schema_stats = result.find { |h| h["schema_stats"] }
      assert schema_stats, "Expected schema_stats in result"
      assert_equal "#{Dir.pwd}/test/dummy/db/schema.rb", schema_stats["schema_stats"]["schema_path"]
      assert_equal 2, schema_stats["schema_stats"]["create_table calls count"]

      polymorphic_stats = result.find { |h| h["polymorphic_stats"] }
      assert polymorphic_stats, "Expected polymorphic_stats in result"
      assert_equal 1, polymorphic_stats["polymorphic_stats"]["polymorphic_models_count"]
    end
  end
end
