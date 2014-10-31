# railties/lib/rails/tasks/statistics.rake

module RailsStats
  module Rake
    STATS_DIRECTORIES = [
      %w(Controllers        app/controllers),
      %w(Helpers            app/helpers),
      %w(Models             app/models),
      %w(Mailers            app/mailers),
      %w(Observers          app/observers),
      %w(Javascripts        app/assets/javascripts),
      %w(Libraries          lib/),
      %w(APIs               app/apis),
      %w(Controller\ tests  test/controllers),
      %w(Helper\ tests      test/helpers),
      %w(Model\ tests       test/models),
      %w(Mailer\ tests      test/mailers),
      %w(Integration\ tests test/integration),
      %w(Functional\ tests\ (old)  test/functional),
      %w(Unit\ tests \ (old)       test/unit),
      %w(Controller\ tests  spec/controllers),
      %w(Helper\ tests      spec/helpers),
      %w(Model\ tests       spec/models),
      %w(Mailer\ tests      spec/mailers),
      %w(Integration\ tests spec/integration),
      %w(Integration\ tests spec/integrations),
      %w(Request\ tests spec/requests),
      %w(Library\ tests spec/lib),
      %w(Cucumber\ tests features),
    ]

    def calculate(root_directory)
      puts "\nDirectory: #{root_directory}\n\n"
      stats_dirs = STATS_DIRECTORIES.collect { |name, dir| [ name, "#{root_directory}/#{dir}" ] }.select { |name, dir| File.directory?(dir) }
      CodeStatistics.new(root_directory).to_s
    end
  end
end
