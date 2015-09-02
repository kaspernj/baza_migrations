class BazaMigrations::Commands::RemoveIndex < BazaMigrations::Commands::Base
  def initialize(table_name, column_name)
    @table_name = table_name

    if column_name.is_a?(Array)
      @index_name = "index_#{@table_name}_on_#{column_name.join("_and_")}"
    else
      @index_name = "index_#{@table_name}_on_#{column_name}"
    end
  end

  def sql
    sqls = []
    db_type = db.opts.fetch(:type)

    if db_type.to_s.include?("sqlite3")
      sqls << proc {
        table = db.tables[@table_name]

        index = table.index(@index_name)
        index.drop
      }
    else
      sqls << "DROP INDEX `#{@index_name}` ON `#{@table_name}`"
    end

    return sqls
  end

  def changed_rollback_sql
    raise BazaMigrations::Errors::IrreversibleMigration
  end
end
