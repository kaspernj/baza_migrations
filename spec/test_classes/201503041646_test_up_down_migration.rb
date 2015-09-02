class TestUpDownMigration < BazaMigrations::Migration
  def up
    create_table :test_table do |t|
      t.string :name
      t.integer :age
      t.timestamps
    end

    add_column :test_table, :email, :string
    add_index :test_table, :email
    add_index :test_table, [:name, :email]
  end

  def down
    remove_index :test_table, [:name, :email]
    remove_index :test_table, :email
    remove_column :test_table, :email
    drop_table :test_table
  end
end
