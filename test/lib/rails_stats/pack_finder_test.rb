# frozen_string_literal: true

require "test_helper"

describe RailsStats::PackFinder do
  describe ".find" do
    it "detects packwerk packs and component-based components" do
      root = File.absolute_path("./test/fixtures/packwerk_app")

      packs = RailsStats::PackFinder.find(root).map { |path| path.sub("#{root}/", "") }

      assert_equal ["components/billing", "packs/pack1", "packs/pack2"], packs.sort
    end

    it "does not treat the root package.yml as a pack" do
      root = File.absolute_path("./test/fixtures/packwerk_app")

      packs = RailsStats::PackFinder.find(root)

      refute_includes packs, root
    end

    it "returns an empty list for a plain Rails app" do
      root = File.absolute_path("./test/dummy")

      assert_empty RailsStats::PackFinder.find(root)
    end
  end
end
