# frozen_string_literal: true

require "test_helper"

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    TABLE = <<~EOS
+----------------------+---------+---------+---------+---------+-----+-------+
| Name                 | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+-----+-------+
| Mailers              |       4 |       4 |       1 |       0 |   0 |     0 |
| Models               |       3 |       3 |       1 |       0 |   0 |     0 |
| Javascripts          |      27 |       7 |       0 |       0 |   0 |     0 |
| Jobs                 |       7 |       2 |       1 |       0 |   0 |     0 |
| Controllers          |       3 |       3 |       1 |       0 |   0 |     0 |
| Helpers              |       3 |       3 |       0 |       0 |   0 |     0 |
| Channels             |       8 |       8 |       2 |       0 |   0 |     0 |
| Configuration        |     417 |     111 |       1 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+-----+-------+
| Code                 |     472 |     141 |       7 |       0 |   0 |     0 |
| Tests                |       0 |       0 |       0 |       0 |   0 |     0 |
| Total                |     472 |     141 |       7 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+-----+-------+
  Code LOC: 141     Test LOC: 0     Code to Test Ratio: 1:0.0

    EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.absolute_path("./test/dummy")
      assert_output(TABLE) do
        RailsStats::CodeStatistics.new(root_directory).to_s
      end
    end
  end
end
