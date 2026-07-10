module RailsStats
  # Vendored / generated directory names we never descend into or treat as a
  # pack. Shared by PackFinder (which builds IGNORED_PATH from it) and Util
  # (which matches them by basename while walking the tree).
  IGNORED_DIRS = %w[node_modules vendor tmp log .git].freeze
end

require 'rails_stats/stats_calculator'
require 'rails_stats/stats_formatter'
require 'rails_stats/json_formatter'
require 'rails_stats/console_formatter'
require 'rails_stats/inflector'
require 'rails_stats/code_statistics_calculator'
require 'rails_stats/pack_finder'
require 'rails_stats/util'
require 'rails_stats/app_statistics'
require 'rails_stats/test_statistics'
require 'rails_stats/spec_statistics'
require 'rails_stats/cucumber_statistics'
require 'rails_stats/root_statistics'
require 'rails_stats/gem_statistics'
require 'rails_stats/code_statistics'
