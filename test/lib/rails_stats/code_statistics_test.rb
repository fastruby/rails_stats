# frozen_string_literal: true

require "test_helper"

Minitest::Test.make_my_diffs_pretty!

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    it "outputs useful stats for a Rails project" do
      root_directory = File.expand_path('../../../test/dummy', File.dirname(__FILE__))
      table = File.read(File.expand_path('../../../fixtures/console-output.txt', __FILE__))

      out, err = capture_io do
        RailsStats::CodeStatistics.new(root_directory).to_s
      end

      # Compare only the code stats portion of the output, skipping the
      # bundler-stats gem table which varies across Ruby versions.
      code_stats_output = out[out.index("+----------------------+")..-1]

      assert_equal(
        table.lines.map(&:rstrip).join,
        code_stats_output.lines.map(&:rstrip).join
      )
    end
  end
end
