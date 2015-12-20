class BazaMigrations::Migrate
  def migrations
    migrations_found = []

    paths.each do |path|
      migrations_path = "#{path}/db/baza_migrate"
      next unless File.exist?(migrations_path)

      Dir.foreach(migrations_path) do |file|
        next unless file[-3, 3] == ".rb"

        match = file.match(/\A(\d+)_(.+)\.rb\Z/)
        const_name = StringCases.snake_to_camel(match[2])

        migrations_found << {
          file: file,
          const_name: const_name,
          full_path: "#{migrations_path}/#{file}"
        }
      end
    end

    migrations_found.sort! { |migration1, migration2| migration1[:file] <=> migration2[:file] }

    migrations_found
  end

  def execute_all_migrations(direction)
    migrations.each do |migration|
      require migration[:full_path]
      migrate_object = Object.const_get(migration[:const_name]).new(db: Baza.default_db)
      migrate_object.migrate(direction)
    end
  end

  def paths
    Enumerator.new do |yielder|
      yielder << Dir.pwd

      Gem.loaded_specs.each do |_name, loaded_spec|
        yielder << loaded_spec.gem_dir
      end
    end
  end
end
