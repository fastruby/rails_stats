require "rails_stats"

class Stats < Thor
  desc "calculate", "get details on a Rails project"
  def calculate(directory)
    RailsStats
    puts "#{directory}"
  end
end