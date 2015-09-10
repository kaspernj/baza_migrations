class TestExistsMethods < BazaMigrations::Migration
  def up
    raise "Table should exist" unless table_exists?(:test_table)
    raise "Column should exist" unless column_exists?(:test_table, :name)
    raise "Index should exist" unless index_exists?(:test_table, :email)
  end
end
