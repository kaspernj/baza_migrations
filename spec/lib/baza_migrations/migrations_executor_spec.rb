require "spec_helper"

describe BazaMigrations::MigrationsExecutor do
  let(:db) do
    file_path = "#{Dir.tmpdir}/baza_migrations.sqlite3"
    File.unlink(file_path) if File.exists?(file_path)
    Baza::Db.new(type: :sqlite3, path: file_path)
  end
  let(:executor) { BazaMigrations::MigrationsExecutor.new(db: db) }
  let(:migrations) { executor.instance_variable_get(:@migrations) }

  it "#add_dir" do
    executor.add_dir("spec/dummy/db/baza_migrate")
    expect(migrations.length).to eq 2
  end

  it "#ordered_migrations" do
    executor.add_dir("spec/dummy/db/baza_migrate")
    ordered_migrations = executor.ordered_migrations

    expect(migrations.first.fetch(:time).strftime("%H:%M")).to eq "16:05"
    expect(migrations[1].fetch(:time).strftime("%H:%M")).to eq "16:18"
  end

  it "#ensure_schema_migrations_table" do
    executor.ensure_schema_migrations_table

    table = db.tables[:baza_schema_migrations]
    expect(table).to_not eq nil
  end

  it "#execute_migrations" do
    executor.add_dir("spec/dummy/db/baza_migrate")
    executor.execute_migrations

    expect(db.select(:baza_schema_migrations, version: "20150901160500").fetch).to_not eq nil
    expect(db.select(:baza_schema_migrations, version: "20150901161800").fetch).to_not eq nil
  end
end
