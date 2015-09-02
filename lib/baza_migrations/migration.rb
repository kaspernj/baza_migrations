class BazaMigrations::Migration
  def initialize(args = {})
    @db = args.fetch(:db)
    raise "No database was given" unless @db

    @changes = []
    check_schema_migrations_table
  end

  def change
    raise BazaMigrations::Errors::NotImplementedError
  end

  def up
    raise BazaMigrations::Errors::NotImplementedError
  end

  def down
    raise BazaMigrations::Errors::NotImplementedError
  end

  def migrate(direction)
    if direction == :up
      begin
        up
        execute_changes
      rescue BazaMigrations::Errors::NotImplementedError
        change
        execute_changes
      end
    elsif direction == :down
      begin
        down
        execute_changes
      rescue BazaMigrations::Errors::NotImplementedError
        change
        rollback_changed_changes
      end
    else
      raise "Invalid direction: #{direction}"
    end

    @changes = []
  end

private

  def create_table(name)
    command = new_command(:CreateTable, name)
    @changes << command

    yield command
  end

  def drop_table(name)
    @changes << new_command(:DropTable, name)
  end

  def add_index(name, columns)
    @changes << new_command(:AddIndex, name, columns)
  end

  def remove_column(table_name, column_name)
    @changes << new_command(:RemoveColumn, table_name, column_name)
  end

  def add_column(table_name, column_name, type)
    @changes << new_command(:AddColumn, table_name, column_name, type)
  end

protected

  def execute_changes
    @changes.each do |change|
      change.sql.each do |sql|
        if sql.is_a?(String)
          @db.q(sql)
        elsif sql.respond_to?(:call)
          sql.call
        else
          raise "Didn't know what to do with: #{sql.class.name}"
        end
      end
    end
  end

  def rollback_changed_changes
    @changes.reverse.each do |change|
      change.changed_rollback_sql.each do |sql|
        if sql.is_a?(String)
          @db.q(sql)
        elsif sql.respond_to?(:call)
          sql.call
        else
          raise "Didn't know what to do with: #{sql.class.name}"
        end
      end
    end
  end

  def new_command(type, *args)
    command = BazaMigrations::Commands.const_get(type).new(*args)
    command.db = @db
    command.table = @schema_migrations_table

    return command
  end

  def check_schema_migrations_table
    begin
      @schema_migrations_table = @db.tables[:schema_migrations]
    rescue Errno::ENOENT
      @db.tables.create(:schema_migrations,
        columns: [{name: :version, type: :varchar}],
        indexes: [:version]
      )
      @schema_migrations_table = @db.tables[:schema_migrations]
    end
  end
end
