class BazaMigrations::Commands::AddIndex < BazaMigrations::Commands::Base
  def initialize(table_name, columns)
    @table_name = table_name
    @columns = columns
  end

  def sql
    sql = "CREATE INDEX `#{@db.esc_col(index_name)}` ON `#{@db.esc_table(@table_name)}` ("

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
    return [@columns]
  end

  def index_name
    name = "index_#{@table_name}_on_"

    first = true
    columns_as_array.each do |column|
      name << "_and_" unless first
      first = false if first
      name << column.to_s
    end

    return name
  end
end
