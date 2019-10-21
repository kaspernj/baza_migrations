class BazaMigrations::Migrate
  def migrations
    executor = BazaMigrations::MigrationsExecutor.new(db: Baza.default_db)

    paths.each do |path|
      migrations_path = "#{path}/db/baza_migrate"
      next unless File.exist?(migrations_path)

      executor.add_dir(migrations_path)
    end

    executor
  end

  def execute_all_migrations(direction)
    migrations.execute_migrations(direction)
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
