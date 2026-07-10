module RailsStats
  # Detects "packs" (packwerk / packs-rails) and "components" (component-based
  # Rails, à la Stephan Hagemann) inside a Rails application so that stats can
  # be reported per pack/component plus a "Core" group for everything else.
  #
  # A directory is considered a pack when either:
  #
  #   * it contains a `package.yml` file (the packwerk marker), or
  #   * it is a direct child of a `packs/` or `components/` directory and holds
  #     any of the usual code folders (`app`, `lib`, `spec`, `test`).
  #
  # Nested packs (e.g. `packs/a/packs/b`) are supported. The root directory
  # itself is never reported as a pack.
  module PackFinder
    extend self

    CODE_FOLDERS   = %w[app lib spec test].freeze
    PACK_CONTAINERS = %w[packs components].freeze
    IGNORED_PATH   = %r{/(vendor|node_modules|tmp|\.git)/}.freeze

    # Returns the absolute paths of every detected pack/component, sorted.
    def find(root_directory)
      root = File.absolute_path(root_directory)
      packs = {}

      collect_packwerk_packs(root, packs)
      collect_convention_packs(root, packs)

      packs.keys.sort
    end

    private

    def collect_packwerk_packs(root, packs)
      Dir.glob(File.join(root, "**", "package.yml")).each do |marker_path|
        next if marker_path =~ IGNORED_PATH

        dir = File.absolute_path(File.dirname(marker_path))
        next if dir == root

        packs[dir] = true
      end
    end

    def collect_convention_packs(root, packs)
      PACK_CONTAINERS.each do |container|
        Dir.glob(File.join(root, "**", container, "*")).each do |path|
          next if path =~ IGNORED_PATH
          next unless File.directory?(path)

          dir = File.absolute_path(path)
          next if dir == root
          next unless code_folder?(dir)

          packs[dir] = true
        end
      end
    end

    def code_folder?(dir)
      CODE_FOLDERS.any? { |folder| File.directory?(File.join(dir, folder)) }
    end
  end
end
