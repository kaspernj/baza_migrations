class BazaMigrations::Commands::RemoveColumn < BazaMigrations::Commands::Base
  def initialize(table_name, columns)
    @table_name = table_name
    @columns = columns
  end

  def sql
    raise 'stub!'
  end

  def changed_rollback_sql
    raise 'stub!'
  end
end
