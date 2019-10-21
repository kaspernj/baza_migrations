class BazaMigrations::MigrationsExecutor
  def initialize(args = {})
    @db = args.fetch(:db)
    @migrations = []
  end

  def add_dir(path)
    path = File.realpath(path)

    Dir.foreach(path) do |file|
      next unless file.end_with?(".rb")

      full_path = "#{path}/#{file}"
      add_file(full_path)
    end
  end

  def add_file(path)
    match = File.basename(path).match(/\A(\d+)_(.+)\.rb\Z/)
    raise "Could not match class name from: #{path}" unless match

    require path
    class_name = StringCases.snake_to_camel(File.basename(match[2], File.extname(path)))

    add_migration(
      class_name: class_name,
      const: Object.const_get(class_name),
      time: Time.parse(match[1])
    )
  end

  def add_migration(args)
    @migrations << {
      class_name: args.fetch(:class_name),
      const: args.fetch(:const),
      time: args.fetch(:time)
    }
  end

  def ordered_migrations
    @migrations.sort do |migration1, migration2|
      migration1.fetch(:time) <=> migration2.fetch(:time)
    end
  end

  def execute_migrations(direction = :up)
    ensure_schema_migrations_table

    ordered_migrations.each do |migration_data|
      next if migration_already_executed?(migration_data)

      migration_data.fetch(:const).new(db: @db).migrate(direction)

      @db.insert(:baza_schema_migrations, version: migration_data.fetch(:time).strftime("%Y%m%d%H%M%S"))
    end
  end

  def migration_already_executed?(migration_data)
    if @db.single(:baza_schema_migrations, version: migration_data.fetch(:time).strftime("%Y%m%d%H%M%S"))
      true
    else
      false
    end
  end

  def ensure_schema_migrations_table
    return if schema_migrations_table_exist?

    @db.tables.create(
      :baza_schema_migrations,
      columns: [
        {name: :version, type: :varchar}
      ],
      indexes: [
        {name: :index_version, columns: [:version], unique: true}
      ]
    )
  end

private

  def schema_migrations_table_exist?
    @db.tables[:baza_schema_migrations]
    true
  rescue Baza::Errors::TableNotFound
    false
  end
end
