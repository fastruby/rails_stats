# frozen_string_literal: true

require "test_helper"

describe RailsStats::JSONFormatter do
  describe "#result" do
    JSON_STRING = <<~EOS
      [{
        "summary": {
          "declared": 9,
          "unpinned": 6,
          "total": 18,
          "github": 0
        },
        "gems": [
          {
            "name": "simplecov-console",
            "total_dependencies": 8,
            "first_level_dependencies": 3,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "ansi (>= 0)",
              "simplecov (>= 0)",
              "terminal-table (>= 0)",
              "docile (~> 1.1)",
              "simplecov-html (~> 0.11)",
              "simplecov_json_formatter (~> 0.1)",
              "unicode-display_width (>= 1.1.1, < 4)",
              "unicode-emoji (~> 4.0, >= 4.0.4)"
            ]
          },
          {
            "name": "codecov",
            "total_dependencies": 4,
            "first_level_dependencies": 1,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "simplecov (>= 0.15, < 0.22)",
              "docile (~> 1.1)",
              "simplecov-html (~> 0.11)",
              "simplecov_json_formatter (~> 0.1)"
            ]
          },
          {
            "name": "rails_stats",
            "total_dependencies": 4,
            "first_level_dependencies": 2,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "bundler-stats (>= 2.1)",
              "rake (>= 0)",
              "bundler (>= 1.9, < 3)",
              "thor (>= 0.19.0, < 2.0)"
            ]
          },
          {
            "name": "simplecov",
            "total_dependencies": 3,
            "first_level_dependencies": 3,
            "top_level_dependencies": {
              "codecov": "codecov (0.6.0)",
              "simplecov-console": "simplecov-console (0.9.3)"
            },
            "transitive_dependencies": [
              "docile (~> 1.1)",
              "simplecov-html (~> 0.11)",
              "simplecov_json_formatter (~> 0.1)"
            ]
          },
          {
            "name": "minitest-around",
            "total_dependencies": 1,
            "first_level_dependencies": 1,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "minitest (~> 5.0)"
            ]
          },
          {
            "name": "bundler",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {
              "bundler-stats": "bundler-stats (2.4.0)",
              "rails_stats": "rails_stats (2.0.1)"
            },
            "transitive_dependencies": []
          },
          {
            "name": "byebug",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {},
            "transitive_dependencies": []
          },
          {
            "name": "minitest",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {
              "minitest-around": "minitest-around (0.5.0)"
            },
            "transitive_dependencies": []
          },
          {
            "name": "minitest-spec-context",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {},
            "transitive_dependencies": []
          }
        ]
        },{
          "name": "Mailers",
          "files": "1",
          "lines": "4",
          "loc": "4",
          "classes": "1",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Helpers",
          "files": "1",
          "lines": "3",
          "loc": "3",
          "classes": "0",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Jobs",
          "files": "1",
          "lines": "7",
          "loc": "2",
          "classes": "1",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Controllers",
          "files": "1",
          "lines": "7",
          "loc": "6",
          "classes": "1",
          "methods": "1",
          "m_over_c": "1",
          "loc_over_m": "4"
        }, {
          "name": "Models",
          "files": "4",
          "lines": "10",
          "loc": "10",
          "classes": "4",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Channels",
          "files": "2",
          "lines": "8",
          "loc": "8",
          "classes": "2",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Javascripts",
          "files": "3",
          "lines": "27",
          "loc": "7",
          "classes": "0",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Libraries",
          "files": "1",
          "lines": "1",
          "loc": "1",
          "classes": "0",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Configuration",
          "files": "19",
          "lines": "417",
          "loc": "111",
          "classes": "1",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Model Tests",
          "files": "2",
          "lines": "5",
          "loc": "4",
          "classes": "2",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Spec Support",
          "files": "1",
          "lines": "1",
          "loc": "1",
          "classes": "0",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Test Support",
          "files": "1",
          "lines": "1",
          "loc": "1",
          "classes": "0",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0"
        }, {
          "name": "Code",
          "files": "33",
          "lines": "484",
          "loc": "152",
          "classes": "10",
          "methods": "1",
          "m_over_c": "0",
          "loc_over_m": "150",
          "code_to_test_ratio": "0.0",
          "total": true
        }, {
          "name": "Tests",
          "files": "4",
          "lines": "7",
          "loc": "6",
          "classes": "2",
          "methods": "0",
          "m_over_c": "0",
          "loc_over_m": "0",
          "code_to_test_ratio": "0.0",
          "total": true
        }, {
          "name": "Total",
          "files": "37",
          "lines": "491",
          "loc": "158",
          "classes": "12",
          "methods": "1",
          "m_over_c": "0",
          "loc_over_m": "156",
          "code_to_test_ratio": "0.0",
          "total": true},
          {"schema_stats":
            {"schema_path":
            "#{Dir.pwd}/test/dummy/db/schema.rb",
            "create_table calls count": 2}},
            {"polymorphic_stats": {"polymorphic_models_count": 1}
          }
        ]
    EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.absolute_path("./test/dummy")

      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::JSONFormatter.new(calculator)

      expectation = JSON.parse(JSON_STRING)
      result = formatter.result

      [expectation, result].each do |data|
        data.each do |hash|
          next unless hash["gems"]

          hash["gems"].each do |gem|
            next unless gem["transitive_dependencies"]

            gem["transitive_dependencies"].map! do |dep|
              name, constraints = dep.split(/[()]/)
              next dep unless constraints

              normalized_constraints = constraints.split(/,\s*/).sort.join(', ')
              "#{name}(#{normalized_constraints})"
            end.sort!
          end
        end
      end

      assert_equal expectation, result
    end
  end
end
