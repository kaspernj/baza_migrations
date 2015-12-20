namespace :baza do
  namespace :db do
    task "migrate" do
      BazaMigrations::Migrate.new.execute_all_migrations(:up)
    end

    task "rollback" do
      BazaMigrations::Migrate.new.execute_all_migrations(:down)
    end
  end
end
