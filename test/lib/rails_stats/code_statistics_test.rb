# frozen_string_literal: true

require "test_helper"

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    TABLE = <<~EOS
+-----------------------|------------|----------------+
|                  Name | Total Deps | 1st Level Deps |
+-----------------------|------------|----------------+
|     simplecov-console | 7          | 3              |
|               codecov | 4          | 1              |
|           rails_stats | 4          | 2              |
|             simplecov | 3          | 3              |
|       minitest-around | 1          | 1              |
|               bundler | 0          | 0              |
|                byebug | 0          | 0              |
|              minitest | 0          | 0              |
| minitest-spec-context | 0          | 0              |
+-----------------------|------------|----------------+
                          \n      Declared Gems   9   \n         Total Gems   17  \n  Unpinned Versions   8   \n        Github Refs   0   \n                          \n+----------------------+---------+---------+---------+---------+-----+-------+
| Name                 | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+-----+-------+
| Channels             |       8 |       8 |       2 |       0 |   0 |     0 |
| Configuration        |     417 |     111 |       1 |       0 |   0 |     0 |
| Controllers          |       7 |       6 |       1 |       1 |   1 |     4 |
| Helpers              |       3 |       3 |       0 |       0 |   0 |     0 |
| Javascripts          |      27 |       7 |       0 |       0 |   0 |     0 |
| Jobs                 |       7 |       2 |       1 |       0 |   0 |     0 |
| Libraries            |       1 |       1 |       0 |       0 |   0 |     0 |
| Mailers              |       4 |       4 |       1 |       0 |   0 |     0 |
| Model Tests          |       5 |       4 |       2 |       0 |   0 |     0 |
| Models               |       3 |       3 |       1 |       0 |   0 |     0 |
| Spec Support         |       1 |       1 |       0 |       0 |   0 |     0 |
| Test Support         |       1 |       1 |       0 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+-----+-------+
| Code                 |     477 |     145 |       7 |       1 |   0 |   143 |
| Tests                |       7 |       6 |       2 |       0 |   0 |     0 |
| Total                |     484 |     151 |       9 |       1 |   0 |   149 |
+----------------------+---------+---------+---------+---------+-----+-------+
  Code LOC: 145     Test LOC: 6     Code to Test Ratio: 1:0.0

    EOS

    TABLE_RUBY_2_4 = <<~EOS
+-----------------------|------------|----------------+
|                  Name | Total Deps | 1st Level Deps |
+-----------------------|------------|----------------+
|     simplecov-console | 6          | 3              |
|           rails_stats | 4          | 2              |
|               codecov | 3          | 1              |
|             simplecov | 2          | 2              |
|       minitest-around | 1          | 1              |
|               bundler | 0          | 0              |
|                byebug | 0          | 0              |
|              minitest | 0          | 0              |
| minitest-spec-context | 0          | 0              |
+-----------------------|------------|----------------+
                          \n      Declared Gems   9   \n         Total Gems   16  \n  Unpinned Versions   8   \n        Github Refs   0   \n                          \n+----------------------+---------+---------+---------+---------+-----+-------+
| Name                 | Lines   |     LOC | Classes | Methods | M/C | LOC/M |
+----------------------+---------+---------+---------+---------+-----+-------+
| Channels             |       8 |       8 |       2 |       0 |   0 |     0 |
| Configuration        |     417 |     111 |       1 |       0 |   0 |     0 |
| Controllers          |       7 |       6 |       1 |       1 |   1 |     4 |
| Helpers              |       3 |       3 |       0 |       0 |   0 |     0 |
| Javascripts          |      27 |       7 |       0 |       0 |   0 |     0 |
| Jobs                 |       7 |       2 |       1 |       0 |   0 |     0 |
| Libraries            |       1 |       1 |       0 |       0 |   0 |     0 |
| Mailers              |       4 |       4 |       1 |       0 |   0 |     0 |
| Model Tests          |       5 |       4 |       2 |       0 |   0 |     0 |
| Models               |       3 |       3 |       1 |       0 |   0 |     0 |
| Spec Support         |       1 |       1 |       0 |       0 |   0 |     0 |
| Test Support         |       1 |       1 |       0 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+-----+-------+
| Code                 |     477 |     145 |       7 |       1 |   0 |   143 |
| Tests                |       7 |       6 |       2 |       0 |   0 |     0 |
| Total                |     484 |     151 |       9 |       1 |   0 |   149 |
+----------------------+---------+---------+---------+---------+-----+-------+
  Code LOC: 145     Test LOC: 6     Code to Test Ratio: 1:0.0

EOS

    it "outputs useful stats for a Rails project" do
      root_directory = File.expand_path('../../../test/dummy', File.dirname(__FILE__))

      out, err = capture_io do
        RailsStats::CodeStatistics.new(root_directory).to_s
      end

      expectation = if RUBY_VERSION < "2.5.0"
        TABLE_RUBY_2_4
      else
        TABLE
      end

      assert_equal expectation, out
    end
  end
end
