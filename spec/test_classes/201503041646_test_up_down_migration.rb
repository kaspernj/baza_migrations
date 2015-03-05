class TestUpDownMigration < BazaMigrations::Migration
  def up
    create_table :test_table do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :test_table
  end
end
