# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

describe RailsStats::Util do
  describe ".calculate_directory_statistics" do
    it "ignores vendored directories and never counts a directory that looks like a source file" do
      Dir.mktmpdir do |dir|
        # A real source file that should be counted.
        File.write(File.join(dir, "real.rb"), "class Real\nend\n")

        # A directory whose name matches the source-file pattern. It must be
        # walked (its contents counted) but never opened as a file itself,
        # which previously raised Errno::EISDIR.
        weird = File.join(dir, "weird.rb")
        FileUtils.mkdir_p(weird)
        File.write(File.join(weird, "inner.rb"), "class Inner\nend\n")

        # A vendored tree that must be skipped entirely, including a directory
        # named like a JS file (e.g. node_modules/popper.js), the exact case
        # that crashed on a packs app.
        popper = File.join(dir, "node_modules", "popper.js")
        FileUtils.mkdir_p(popper)
        File.write(File.join(popper, "index.js"), "function noop() {}\n")

        stats = RailsStats::Util.calculate_directory_statistics(dir)

        # real.rb + weird.rb/inner.rb, nothing under node_modules.
        assert_equal 2, stats.files_total
      end
    end

    it "skips every ignored directory name" do
      RailsStats::IGNORED_DIRS.each do |ignored|
        Dir.mktmpdir do |dir|
          vendored = File.join(dir, ignored)
          FileUtils.mkdir_p(vendored)
          File.write(File.join(vendored, "ignored.rb"), "class Ignored\nend\n")

          stats = RailsStats::Util.calculate_directory_statistics(dir)

          assert_equal 0, stats.files_total, "expected #{ignored}/ to be skipped"
        end
      end
    end
  end
end
