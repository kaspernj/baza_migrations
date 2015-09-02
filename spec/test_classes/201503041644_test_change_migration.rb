class TestChangeMigration < BazaMigrations::Migration
  def change
    create_table :table do |t|
      t.string :name
      t.integer :age
      t.timestamps
    end

    add_index :table, :name
  end
end
