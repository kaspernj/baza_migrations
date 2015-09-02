require "spec_helper"

describe BazaMigrations::Migration do
  let(:db) do
    file_path = "#{Dir.tmpdir}/baza_migrations.sqlite3"
    File.unlink(file_path) if File.exists?(file_path)
    Baza::Db.new(type: :sqlite3, path: file_path)
  end

  let(:change_migration) do
    require "#{File.dirname(__FILE__)}/../../test_classes/201503041644_test_change_migration.rb"
    TestChangeMigration.new(db: db)
  end

  let(:up_down_migration) do
    require "#{File.dirname(__FILE__)}/../../test_classes/201503041646_test_up_down_migration.rb"
    TestUpDownMigration.new(db: db)
  end

  it "#check_schema_migrations_table" do
    change_migration
    db.tables[:schema_migrations].name.should eq :schema_migrations
  end

  it "#up" do
    up_down_migration.migrate(:up)

    table = db.tables[:test_table]
    table.name.should eq :test_table

    age_column = table.column(:age)
    age_column.type.should eq :int
  end

  it "#down" do
    up_down_migration.migrate(:up)

    table = db.tables[:test_table]
    table.name.should eq :test_table

    up_down_migration.migrate(:down)
    db.tables.instance_variable_set(:@list, Wref_map.new) # Resets cache

    expect { db.tables[:test_table] }.to raise_error
  end

  describe "#change" do
    it "migrates" do
      change_migration.migrate(:up)
      table = db.tables[:table]
      table.name.should eq :table
    end

    it "rolls back" do
      change_migration.migrate(:up)
      table = db.tables[:table]
      table.name.should eq :table

      change_migration.migrate(:down)
      db.tables.instance_variable_set(:@list, Wref_map.new) # Resets cache

      expect { db.tables[:table] }.to raise_error
    end
  end
end
