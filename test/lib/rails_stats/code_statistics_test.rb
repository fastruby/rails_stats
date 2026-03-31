# frozen_string_literal: true

require "test_helper"

Minitest::Test.make_my_diffs_pretty!

describe RailsStats::CodeStatistics do
  describe "#to_s" do
    it "outputs useful stats for a Rails project" do
      root_directory = File.expand_path('../../../test/dummy', File.dirname(__FILE__))
      expected_table = File.read(File.expand_path('../../../fixtures/console-output.txt', __FILE__))

      expected_bundler_table, _ = capture_io { Bundler::Stats::CLI.start }

      output, _ = capture_io { RailsStats::CodeStatistics.new(root_directory).to_s }

      assert_equal([expected_bundler_table, expected_table].join, output)
    end
  end
end
