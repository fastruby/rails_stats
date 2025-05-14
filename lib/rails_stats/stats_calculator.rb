module RailsStats
  class StatsCalculator
    RAILS_APP_FOLDERS = ['models',
                         'controllers',
                         'helpers',
                         'mailers',
                         'views',
                         'assets']

    def initialize(root_directory)
      @root_directory = root_directory
      @schema_path    = File.join(@root_directory, "db", "schema.rb")
      @structure_path = File.join(@root_directory, "db", "structure.sql")
      @key_concepts   = calculate_key_concepts
      @projects       = calculate_projects
      @statistics     = calculate_statistics
      @code_loc       = calculate_code
      @test_loc       = calculate_tests
      @schema         = calculate_create_table_calls
      @sti            = calculate_sti
      @polymorphic    = calculate_polymorphic
      @files_total, @code_total, @tests_total, @grand_total = calculate_totals
    end

    attr_reader :code_loc, :code_total, :files_total, :grand_total, :statistics, :test_loc, :tests_total, :schema, :schema_path, :structure_path, :sti, :polymorphic

    private

      def calculate_key_concepts
        # returns names of main things like models, controllers, services, etc
        concepts = {}
        app_projects.each do |project|
          project.key_concepts.each do |key|
            concepts[key] = true
          end
        end

        # TODO: maybe gem names?

        concepts.keys
      end

      def calculate_projects
        out = []
        out += app_projects
        out += calculate_root_projects
        out += calculate_gem_projects
        out += calculate_spec_projects
        out += calculate_test_projects
        out += calculate_cucumber_projects
        out
      end

      def app_projects
        @app_projects ||= calculate_app_projects
      end

      def calculate_app_projects
        apps = Util.calculate_projects(@root_directory, "**", "app", RAILS_APP_FOLDERS)
        apps.collect do |root_path|
          AppStatistics.new(root_path)
        end
      end

      def calculate_gem_projects
        gems = Util.calculate_projects(@root_directory, "*", "**", "*.gemspec")
        gems.collect do |root_path|
          GemStatistics.new(root_path)
        end
      end

      def calculate_spec_projects
        specs = Util.calculate_shared_projects("spec", @root_directory, "**", "spec", "**", "*_spec.rb")
        specs.collect do |root_path|
          SpecStatistics.new(root_path, @key_concepts)
        end
      end

      def calculate_test_projects
        tests = Util.calculate_shared_projects("test", @root_directory, "**", "test", "**", "*_test.rb")
        tests.collect do |root_path|
          TestStatistics.new(root_path, @key_concepts)
        end
      end

      def calculate_root_projects
        [RootStatistics.new(@root_directory)]
      end

      def calculate_cucumber_projects
        cukes = Util.calculate_projects(@root_directory, "**", "*.feature")
        cukes.collect do |root_path|
          CucumberStatistics.new(root_path)
        end
      end

      def calculate_statistics
        out = {}
        @projects.each do |project|
          project.statistics.each do |key, stats|
            out[key] ||= CodeStatisticsCalculator.new(project.test)
            out[key].add(stats)
          end
        end
        out
      end

      def calculate_totals
        files_total = @statistics.sum do |k,value|
          value.files_total
        end

        code_total = @statistics.each_with_object(CodeStatisticsCalculator.new) do |pair, code_total|
          code_total.add(pair.last) unless pair.last.test
        end

        tests_total = @statistics.each_with_object(CodeStatisticsCalculator.new) do |pair, tests_total|
          tests_total.add(pair.last) if pair.last.test
        end

        grand_total = @statistics.each_with_object(CodeStatisticsCalculator.new) do |pair, total|
          total.add(pair.last)
        end

        [files_total, code_total, tests_total, grand_total]
      end

      def calculate_code
        @code_loc = 0
        @statistics.each { |k, v| @code_loc += v.code_lines unless v.test }
        @code_loc
      end

      def calculate_tests
        @test_loc = 0
        @statistics.each { |k, v| @test_loc += v.code_lines if v.test }
        @test_loc
      end

      def calculate_create_table_calls
        if @schema_path && File.exist?(@schema_path)
          count_create_table_calls(schema_path, "create_table")
        elsif @structure_path && File.exist?(@structure_path)
          count_create_table_calls(structure_path, "CREATE TABLE")
        else
          0
        end
      end

      def count_create_table_calls(file_path, keyword)
        create_table_count = 0
        File.foreach(file_path) do |line|
          create_table_count += 1 if line.strip.start_with?(keyword)
        end
        create_table_count
      end

      def calculate_sti
        @sti = 0
        Dir.glob(File.join(@root_directory, "app", "models", "*.rb")).each do |file|
          File.foreach(file) do |line|
            if line =~ /class\s+(\w+)\s*<\s*(\w+)/ && !(line =~ /class\s+(\w+)\s*<\s*(ActiveRecord::Base|ApplicationRecord)/)
              @sti += 1
            end
          end
        end
        @sti
      end

      def calculate_polymorphic
        polymorphic_count = 0
        Dir.glob(File.join(@root_directory, "app", "models", "*.rb")).each do |file|
          File.foreach(file) do |line|
            if line =~ /belongs_to\s+:\w+,\s+polymorphic:\s+true/
              polymorphic_count += 1
            end
          end
        end
        polymorphic_count
      end
  end
end