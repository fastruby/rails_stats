# frozen_string_literal: true

require 'test_helper'

describe RailsStats::ConsoleFormatter do
  describe '#to_s' do
    it 'invokes Bundler::Stats::CLI with text format' do
      root_directory = File.absolute_path('./test/dummy')
      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::ConsoleFormatter.new(calculator)

      received_args = nil
      original = Bundler::Stats::CLI.method(:start)
      Bundler::Stats::CLI.define_singleton_method(:start) { |args = []| received_args = args }

      begin
        capture_io { formatter.to_s }
      ensure
        Bundler::Stats::CLI.singleton_class.remove_method(:start)
        Bundler::Stats::CLI.define_singleton_method(:start, original)
      end

      assert_equal ['--format', 'text'], received_args
    end

    it 'prints a section per pack plus a Core and a grand total for packwerk apps' do
      root_directory = File.absolute_path('./test/fixtures/packwerk_app')
      calculator = RailsStats::StatsCalculator.new(root_directory)
      formatter  = RailsStats::ConsoleFormatter.new(calculator)

      original = Bundler::Stats::CLI.method(:start)
      Bundler::Stats::CLI.define_singleton_method(:start) { |args = []| nil }

      begin
        output, _ = capture_io { formatter.to_s }
      ensure
        Bundler::Stats::CLI.singleton_class.remove_method(:start)
        Bundler::Stats::CLI.define_singleton_method(:start, original)
      end

      assert_includes output, '== Core Application =='
      assert_includes output, '== Pack: packs/pack1 =='
      assert_includes output, '== Pack: packs/pack2 =='
      assert_includes output, '== Pack: components/billing =='
      assert_includes output, '== Total (all packs) =='
    end
  end
end
