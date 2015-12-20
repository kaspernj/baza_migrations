class BazaMigrations::Commands::AddColumn < BazaMigrations::Commands::Base
  def initialize(table_name, column_name, type)
    @table_name = table_name
    @column_name = column_name
    @type = type
  end

  def sql
    ["ALTER TABLE `#{@table_name}` ADD COLUMN `#{@column_name}` #{@type};"]
  end

  def changed_rollback_sql
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
end
