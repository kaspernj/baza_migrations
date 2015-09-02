class TestUpDownMigration < BazaMigrations::Migration
  def up
    create_table :test_table do |t|
      t.string :name
      t.integer :age
      t.timestamps
    end

    add_column :test_table, :email, :string
  end

  def down
    remove_column :test_table, :email
    drop_table :test_table
  end
end
