# railties/lib/rails/code_statistics.rb

module RailsStats
  class CodeStatistics

    RAILS_APP_FOLDERS = ['models',
                         'controllers',
                         'helpers',
                         'mailers',
                         'views',
                         'assets']

    def initialize(root_directory)
      @root_directory = root_directory
      @key_concepts   = calculate_key_concepts
      @projects       = calculate_projects
      @statistics     = calculate_statistics
      @total          = calculate_total
    end

    def to_s
      print_header
      @statistics.each { |key, stats| print_line(key, stats) }
      print_splitter

      if @total
        print_line("Total", @total)
        print_splitter
      end

      print_code_test_stats
    end

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

      def calculate_total
        @statistics.each_with_object(CodeStatisticsCalculator.new) do |pair, total|
          total.add(pair.last)
        end
      end

      def calculate_code
        code_loc = 0
        @statistics.each { |k, v| code_loc += v.code_lines unless v.test }
        code_loc
      end

      def calculate_tests
        test_loc = 0
        @statistics.each { |k, v| test_loc += v.code_lines if v.test }
        test_loc
      end

      def print_header
        print_splitter
        puts "| Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |"
        print_splitter
      end

      def print_splitter
        puts "+----------------------+-------+-------+---------+---------+-----+-------+"
      end

      def print_line(name, statistics)
        m_over_c   = (statistics.methods / statistics.classes) rescue m_over_c = 0
        loc_over_m = (statistics.code_lines / statistics.methods) - 2 rescue loc_over_m = 0

        puts "| #{name.ljust(20)} " \
             "| #{statistics.lines.to_s.rjust(5)} " \
             "| #{statistics.code_lines.to_s.rjust(5)} " \
             "| #{statistics.classes.to_s.rjust(7)} " \
             "| #{statistics.methods.to_s.rjust(7)} " \
             "| #{m_over_c.to_s.rjust(3)} " \
             "| #{loc_over_m.to_s.rjust(5)} |"
      end

      def print_code_test_stats
        code  = calculate_code
        tests = calculate_tests

        puts "  Code LOC: #{code}     Test LOC: #{tests}     Code to Test Ratio: 1:#{sprintf("%.1f", tests.to_f/code)}"
        puts ""
      end
  end
end
