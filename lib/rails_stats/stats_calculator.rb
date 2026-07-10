module RailsStats
  class StatsCalculator
    RAILS_APP_FOLDERS = ['models',
                         'controllers',
                         'helpers',
                         'mailers',
                         'views',
                         'assets']

    def initialize(root_directory)
      @root_directory = File.absolute_path(root_directory)
      @schema_path    = File.join(@root_directory, "db", "schema.rb")
      @structure_path = File.join(@root_directory, "db", "structure.sql")
      @pack_roots     = PackFinder.find(@root_directory)
      @key_concepts   = calculate_key_concepts
      @projects       = calculate_projects
      @statistics     = calculate_statistics
      @statistics_by_group = calculate_statistics_by_group
      @code_loc       = calculate_code
      @test_loc       = calculate_tests
      @schema         = calculate_create_table_calls
      @polymorphic    = calculate_polymorphic
      @files_total, @code_total, @tests_total, @grand_total = calculate_totals
    end

    attr_reader :code_loc, :code_total, :files_total, :grand_total, :statistics, :test_loc, :tests_total, :schema, :schema_path, :structure_path, :polymorphic, :pack_roots, :statistics_by_group

    CORE_GROUP = "Core".freeze

    # Returns true when the application is split into packs/components, i.e.
    # there is at least one group beyond the core application.
    def packs?
      @pack_roots.any?
    end

    # Given a {concept => CodeStatisticsCalculator} hash (such as one of the
    # values in +statistics_by_group+ or the flat +statistics+), returns the
    # [code, tests, grand] totals for that group.
    def totals_for(group_statistics)
      code  = CodeStatisticsCalculator.new
      tests = CodeStatisticsCalculator.new
      grand = CodeStatisticsCalculator.new

      group_statistics.each_value do |stats|
        grand.add(stats)
        stats.test ? tests.add(stats) : code.add(stats)
      end

      [code, tests, grand]
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
        projects = [RootStatistics.new(@root_directory)]
        projects + calculate_pack_root_projects
      end

      # Packs that are not self-contained gems/engines (no gemspec) still have
      # a `lib` (and sometimes `config`) directory that would otherwise be
      # missed, since only the root RootStatistics scans the top-level lib.
      # Gems are already covered by GemStatistics, so skip them here to avoid
      # double-counting.
      def calculate_pack_root_projects
        @pack_roots.reject { |pack_root| gem_pack?(pack_root) }.collect do |pack_root|
          RootStatistics.new(pack_root)
        end
      end

      def gem_pack?(pack_root)
        Dir[File.join(pack_root, "*.gemspec")].any?
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

      # Same aggregation as +calculate_statistics+, but keeps each project's
      # numbers grouped by the pack/component it belongs to (or "Core"). The
      # returned hash is ordered with "Core" first followed by packs sorted by
      # their relative path.
      def calculate_statistics_by_group
        grouped = {}
        @projects.each do |project|
          group = group_key_for(project.directory)
          grouped[group] ||= {}
          project.statistics.each do |key, stats|
            grouped[group][key] ||= CodeStatisticsCalculator.new(project.test)
            grouped[group][key].add(stats)
          end
        end

        # Drop empty concepts so a pack with, say, only models does not list a
        # bunch of zero-line rows.
        grouped.each_value do |group_statistics|
          group_statistics.delete_if { |_key, stats| stats.lines == 0 }
        end
        grouped.delete_if { |_group, group_statistics| group_statistics.empty? }

        sort_groups(grouped)
      end

      def sort_groups(grouped)
        ordered = {}
        ordered[CORE_GROUP] = grouped[CORE_GROUP] if grouped.key?(CORE_GROUP)
        grouped.keys.reject { |key| key == CORE_GROUP }.sort.each do |key|
          ordered[key] = grouped[key]
        end
        ordered
      end

      # Maps a project directory to its group: the relative path of the pack it
      # lives in, or "Core" when it belongs to the main application.
      def group_key_for(directory)
        pack_root = pack_root_for(directory)
        return CORE_GROUP unless pack_root

        relative = pack_root.sub(/\A#{Regexp.escape(@root_directory)}\/?/, "")
        relative.empty? ? CORE_GROUP : relative
      end

      # Returns the most specific (longest matching) pack root that contains the
      # given directory, or nil when it is not part of any pack.
      def pack_root_for(directory)
        directory = File.absolute_path(directory.to_s)
        best = nil
        @pack_roots.each do |pack_root|
          next unless directory == pack_root || directory.start_with?("#{pack_root}/")
          best = pack_root if best.nil? || pack_root.length > best.length
        end
        best
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