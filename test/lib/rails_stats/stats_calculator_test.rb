# frozen_string_literal: true

require "test_helper"

describe RailsStats::StatsCalculator do
  describe "#statistics_by_group" do
    before do
      root = File.absolute_path("./test/fixtures/packwerk_app")
      @calculator = RailsStats::StatsCalculator.new(root)
    end

    it "reports that the app is split into packs" do
      assert @calculator.packs?
    end

    it "groups statistics per pack/component with Core first" do
      groups = @calculator.statistics_by_group.keys

      assert_equal "Core", groups.first
      assert_equal ["Core", "components/billing", "packs/pack1", "packs/pack2"], groups
    end

    it "attributes each pack's files to its own group" do
      by_group = @calculator.statistics_by_group

      assert_equal 1, by_group["packs/pack1"]["Models"].files_total
      assert_equal 1, by_group["packs/pack1"]["Controllers"].files_total
      assert_equal 1, by_group["packs/pack1"]["Model Tests"].files_total
      assert_equal 1, by_group["packs/pack2"]["Models"].files_total
      assert_equal 1, by_group["components/billing"]["Models"].files_total
    end

    it "keeps core files in the Core group" do
      core = @calculator.statistics_by_group["Core"]

      assert_equal 1, core["Models"].files_total
      assert_equal 1, core["Controllers"].files_total
      assert_equal 1, core["Libraries"].files_total
    end

    it "includes pack lib directories that are not gems" do
      assert_equal 1, @calculator.statistics_by_group["packs/pack1"]["Libraries"].files_total
    end

    it "has a grand total that matches the sum of every group" do
      _code, _tests, grand = @calculator.totals_for(@calculator.statistics)

      per_group_files = @calculator.statistics_by_group.sum do |_group, stats|
        _c, _t, group_grand = @calculator.totals_for(stats)
        group_grand.files_total
      end

      assert_equal grand.files_total, per_group_files
    end
  end

  describe "#packs?" do
    it "is false for a plain Rails app" do
      calculator = RailsStats::StatsCalculator.new(File.absolute_path("./test/dummy"))

      refute calculator.packs?
    end
  end
end
