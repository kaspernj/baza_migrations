namespace :baza do
  namespace :db do
    desc "Runs all missing migrations"
    task "migrate" do
      BazaMigrations::Migrate.new.execute_all_migrations(:up)
    end

    desc "Runs all migrations back?"
    task "rollback" do
      BazaMigrations::Migrate.new.execute_all_migrations(:down)
    end
  end
end
