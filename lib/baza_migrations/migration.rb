class BazaMigrations::Migration
  def initialize(args = {})
    @db = args.fetch(:db)
    raise "No database was given" unless @db

    @changes = []
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

  def add_index(name, columns, args = {})
    @changes << new_command(:AddIndex, name, columns, args)
  end

  def remove_index(table_name, index_name)
    @changes << new_command(:RemoveIndex, table_name, index_name)
  end

  def add_column(table_name, column_name, type)
    @changes << new_command(:AddColumn, table_name, column_name, type)
  end

  def remove_column(table_name, column_name)
    @changes << new_command(:RemoveColumn, table_name, column_name)
  end

  def table_exists?(table_name)
    @db.tables[table_name]
    true
  rescue Errno::ENOENT
    false
  end

  def column_exists?(table_name, column_name)
    @db.tables[table_name].column(column_name)
    true
  rescue Errno::ENOENT
    false
  end

  def index_exists?(table_name, column_names)
    column_names = [column_names] unless column_names.is_a?(Array)
    index_name = "index_#{table_name}_on_#{column_names.join("_and_")}"

    begin
      @db.tables[table_name].index(index_name)
      true
    rescue Errno::ENOENT
      false
    end
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
    @changes.reverse_each do |change|
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

  def new_command(type, *)
    command = BazaMigrations::Commands.const_get(type).new(*)
    command.db = @db
    command.table = @schema_migrations_table

    command
  end
end
