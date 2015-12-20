class BazaMigrations::Commands::AddIndex < BazaMigrations::Commands::Base
  def initialize(table_name, columns, args)
    @table_name = table_name
    @columns = columns
    @args = args
  end

  def sql
    sql = "CREATE"
    sql << " UNIQUE" if @args[:unique]
    sql << " INDEX `#{@db.esc_col(index_name)}` ON `#{@db.esc_table(@table_name)}` ("

    first = true
    columns_as_array.each do |column|
      sql << ", " unless first
      first = false if first
      sql << "`#{column}`"
    end

    sql << ")"

    [sql]
  end

  def changed_rollback_sql
    ["DROP INDEX `#{@db.esc_col(index_name)}`"]
  end

private

  def columns_as_array
    return @columns if @columns.is_a?(Array)
    [@columns]
  end

  def index_name
    name = "index_#{@table_name}_on_"

    first = true
    columns_as_array.each do |column|
      name << "_and_" unless first
      first = false if first
      name << column.to_s
    end

    name
  end
end
