# frozen_string_literal: true

require "test_helper"

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    TABLE = <<~EOS
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
| Mailers              |       4 |       4 |       1 |       0 |   0 |     0 |
| Models               |       3 |       3 |       1 |       0 |   0 |     0 |
+----------------------+---------+---------+---------+---------+-----+-------+
| Code                 |     476 |     144 |       7 |       1 |   0 |   142 |
| Tests                |       0 |       0 |       0 |       0 |   0 |     0 |
| Total                |     476 |     144 |       7 |       1 |   0 |   142 |
+----------------------+---------+---------+---------+---------+-----+-------+
  Code LOC: 144     Test LOC: 0     Code to Test Ratio: 1:0.0

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
