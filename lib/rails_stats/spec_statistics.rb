module RailsStats
  class SpecStatistics
    attr_reader :statistics, :total, :test

    SPEC_FOLDERS = ['controllers',
                    'features',
                    'helpers',
                    'models',
                    'requests',
                    'routing',
                    'integrations',
                    'integration',
                    'mailers',
                    'lib']

    def initialize(directory, key_concepts)
      @test = true
      @directory    = directory
      @key_concepts = key_concepts
      @statistics   = calculate_statistics
      @total        = calculate_total
    end

    private

    def calculate_total
      out = CodeStatisticsCalculator.new(true)
      @statistics.each do |key, stats|
        out.add(stats)
      end
      out
    end

    def calculate_statistics
      out = {}
      categorize_files.each do |key, list|
        out[key] = Util.calculate_file_statistics(list)
      end 
      out
    end

    def categorize_files
      out = {}
      Dir[File.join(@directory, "**", "*.rb")].each do |file_path|
        if file_path =~ /.*_spec.rb$/
          key = categorize_file(file_path)
        else
          key = "Test Support"
        end

        out[key] ||= []
        out[key]  << file_path
      end

      out
    end

    def categorize_file(file_path)
      types = (@key_concepts + SPEC_FOLDERS).uniq
      types.each do |folder|
        if file_path =~ /\/#{folder}\//
          folder = Inflector.humanize(folder)
          folder = Inflector.titleize(folder)
          folder = Inflector.singularize(folder)
          return "#{folder} Tests"
        end
      end

      # something else
      return "Test"
    end
  end

end
