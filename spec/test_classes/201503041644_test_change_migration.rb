class TestChangeMigration < BazaMigrations::Migration
  def change
    create_table :table do |t|
      t.string :name
      t.integer :age
      t.timestamps
    end

    add_column :table, :email, :string
    add_index :table, :email
    add_index :table, [:name, :email]
  end
end
