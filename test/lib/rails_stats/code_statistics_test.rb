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

      assert_equal table.delete(" \n"), out.delete(" \n")
    end
  end
end
