class BazaMigrations::Commands::RemoveColumn < BazaMigrations::Commands::Base
  def initialize(table_name, column_name)
    @table_name = table_name
    @column_name = column_name
  end

  def sql
    sqls = []
    db_type = db.opts.fetch(:type)

    if db_type.to_s.include?("sqlite3")
      sqls << proc do
        table = db.tables[@table_name]

        column = table.column(@column_name)
        column.drop
      end
    else
      sqls << "ALTER TABLE `#{@table_name}` DROP COLUMN `#{@column_name}`"
    end

    sqls
  end

  def changed_rollback_sql
    raise BazaMigrations::Errors::IrreversibleMigration
  end
end
