# frozen_string_literal: true

require "test_helper"

Minitest::Test.make_my_diffs_pretty!

describe RailsStats::CodeStatistics do
  describe "#to_s" do
  TABLE = <<~EOS
+-----------------------|------------|----------------+
|                  Name | Total Deps | 1st Level Deps |
+-----------------------|------------|----------------+
|     simplecov-console | 7          | 3              |
|               codecov | 5          | 2              |
|           rails_stats | 4          | 2              |
|             simplecov | 3          | 3              |
|       minitest-around | 1          | 1              |
|               bundler | 0          | 0              |
|                byebug | 0          | 0              |
|              minitest | 0          | 0              |
| minitest-spec-context | 0          | 0              |
+-----------------------|------------|----------------+

      Declared Gems   9
         Total Gems   18
  Unpinned Versions   8
        Github Refs   0
  
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Name                 | Files   | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Channels             |       2 |       8 |       8 |       2 |       0 |   0 |     0 |
| Configuration        |      19 |     417 |     111 |       1 |       0 |   0 |     0 |
| Controllers          |       1 |       7 |       6 |       1 |       1 |   1 |     4 |
| Helpers              |       1 |       3 |       3 |       0 |       0 |   0 |     0 |
| Javascripts          |       3 |      27 |       7 |       0 |       0 |   0 |     0 |
| Jobs                 |       1 |       7 |       2 |       1 |       0 |   0 |     0 |
| Libraries            |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
| Mailers              |       1 |       4 |       4 |       1 |       0 |   0 |     0 |
| Model Tests          |       2 |       5 |       4 |       2 |       0 |   0 |     0 |
| Models               |       1 |       3 |       3 |       1 |       0 |   0 |     0 |
| Spec Support         |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
| Test Support         |       1 |       1 |       1 |       0 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
| Code                 |      30 |     477 |     145 |       7 |       1 |   0 |   143 |
| Tests                |       4 |       7 |       6 |       2 |       0 |   0 |     0 |
| Total                |      34 |     484 |     151 |       9 |       1 |   0 |   149 |
+----------------------+---------+---------+---------+---------+---------+-----+-------+
  Code LOC: 145     Test LOC: 6     Code to Test Ratio: 1:0.0  Files: 34
EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.expand_path('../../../test/dummy', File.dirname(__FILE__))

      out, err = capture_io do
        RailsStats::CodeStatistics.new(root_directory).to_s
      end

      assert_equal TABLE, out
    end
  end
end
