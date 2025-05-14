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
      "files": "4",
      "lines": "10",
      "loc": "10",
      "classes": "4",
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
      "lines": "419",
      "loc": "113",
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
      "files": "37",
      "lines": "493",
      "loc": "160",
      "classes": "12",
      "methods": "1",
      "m_over_c": "0",
      "loc_over_m": "158",
      "code_to_test_ratio": "0.0",
      "total": true
    }, {
      "schema_stats": {
        "schema_path": "#{File.absolute_path("./test/dummy/db/schema.rb")}",
        "create_table calls count": 2
      }
    }, {
      "sti_stats": {
        "sti_models_count": 1
      }
    }, {
      "polymorphic_stats": {
        "polymorphic_models_count": 1
      }
    }]
    EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.absolute_path("./test/dummy")

      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::JSONFormatter.new(calculator)

      parsed_expectation = JSON.parse(JSON_STRING)
      parsed_result      = formatter.result

      named_expectation    = parsed_expectation.select { |h| h.key?("name") }.sort_by { |h| h["name"] }
      metadata_expectation = parsed_expectation.reject { |h| h.key?("name") }

      named_result    = parsed_result.select { |h| h.key?("name") }.sort_by { |h| h["name"] }
      metadata_result = parsed_result.reject { |h| h.key?("name") }

      named_expectation.each_with_index do |x, i|
        assert_equal x, named_result[i]
      end

      metadata_expectation.each_with_index do |x, i|
        assert_equal x, metadata_result[i]
      end
    end
  end
end
