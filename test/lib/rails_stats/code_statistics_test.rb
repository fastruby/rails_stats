# frozen_string_literal: true

require "test_helper"
require "json"

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    context "when format is not specified" do
      TABLE = <<~EOS
      +----------------------+-------+-------+---------+---------+-----+-------+
      | Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
      +----------------------+-------+-------+---------+---------+-----+-------+
      | Mailers              |     4 |     4 |       1 |       0 |   0 |     0 |
      | Models               |     3 |     3 |       1 |       0 |   0 |     0 |
      | Javascripts          |    27 |     7 |       0 |       0 |   0 |     0 |
      | Jobs                 |     7 |     2 |       1 |       0 |   0 |     0 |
      | Controllers          |     3 |     3 |       1 |       0 |   0 |     0 |
      | Helpers              |     3 |     3 |       0 |       0 |   0 |     0 |
      | Channels             |     8 |     8 |       2 |       0 |   0 |     0 |
      | Configuration        |   417 |   111 |       1 |       0 |   0 |     0 |
      +----------------------+-------+-------+---------+---------+-----+-------+
      | Total                |   472 |   141 |       7 |       0 |   0 |     0 |
      +----------------------+-------+-------+---------+---------+-----+-------+
        Code LOC: 141     Test LOC: 0     Code to Test Ratio: 1:0.0

      EOS

      it "outputs useful stats for a Rails project" do
        root_directory = File.absolute_path("./test/dummy")
        assert_output(TABLE) do
          RailsStats::CodeStatistics.new(root_directory).to_s
        end
      end
    end

    context "when format is specified as json" do
      JSON_STRING = <<~EOS
  [{\"name\":\"Mailers\",\"lines\":\"4\",\"loc\":\"4\",\"classes\":\"1\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Models\",\"lines\":\"3\",\"loc\":\"3\",\"classes\":\"1\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Javascripts\",\"lines\":\"27\",\"loc\":\"7\",\"classes\":\"0\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Jobs\",\"lines\":\"7\",\"loc\":\"2\",\"classes\":\"1\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Controllers\",\"lines\":\"3\",\"loc\":\"3\",\"classes\":\"1\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Helpers\",\"lines\":\"3\",\"loc\":\"3\",\"classes\":\"0\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Channels\",\"lines\":\"8\",\"loc\":\"8\",\"classes\":\"2\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Configuration\",\"lines\":\"417\",\"loc\":\"111\",\"classes\":\"1\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\"},{\"name\":\"Total\",\"lines\":\"472\",\"loc\":\"141\",\"classes\":\"7\",\"methods\":\"0\",\"m_over_c\":\"0\",\"loc_over_m\":\"0\",\"code_to_test_ratio\":\"0.0\",\"total\":true}]
      EOS

      it "outputs useful stats for a Rails project" do
        root_directory = File.absolute_path("./test/dummy")
        assert_output(JSON_STRING) do
          RailsStats::CodeStatistics.new(root_directory, format: "json").to_s
        end
      end
    end
  end

end
