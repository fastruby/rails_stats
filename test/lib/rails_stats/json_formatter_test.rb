# frozen_string_literal: true

require "test_helper"

describe RailsStats::JSONFormatter do
  describe "#result" do
    JSON_STRING = <<~EOS
    [{
      "name": "Libraries",
      "files": "1",
      "lines": "1",
      "loc": "1",
      "classes": "0",
      "methods": "0",
      "m_over_c": "0",
      "loc_over_m": "0"
    }, {
      "name": "Mailers",
      "files": "1",
      "lines": "4",
      "loc": "4",
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
      "name": "Models",
      "files": "1",
      "lines": "3",
      "loc": "3",
      "classes": "1",
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
      "name": "Helpers",
      "files": "1",
      "lines": "3",
      "loc": "3",
      "classes": "0",
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
      "name": "Configuration",
      "files": "19",
      "lines": "417",
      "loc": "111",
      "classes": "1",
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
      "name": "Total",
      "files": "34",
      "lines": "484",
      "loc": "151",
      "classes": "9",
      "methods": "1",
      "m_over_c": "0",
      "loc_over_m": "149",
      "code_to_test_ratio": "0.0",
      "total": true
    }, {
      "schema_stats": {
        "schema_path": "db/schema.rb",
        "create_table_calls_count": 5
      }
    }, {
      "sti_stats": {
        "sti_models_count": 3
      }
    }, {
      "polymorphic_stats": {
        "polymorphic_models_count": 2
      }
    }]
    EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.absolute_path("./test/dummy")

      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::JSONFormatter.new(calculator)

      sorted_expectation = JSON.parse(JSON_STRING).sort {|x, y| x["name"] <=> y["name"] }
      sorted_result      = formatter.result.sort {|x, y| x["name"] <=> y["name"] }

      sorted_expectation.each_with_index do |x, i|
        assert_equal x, sorted_result[i]
      end
    end
  end
end