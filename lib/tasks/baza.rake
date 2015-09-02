namespace :baza do
  namespace :db do
    task "migrate" do
      migrate = BazaMigrations::Migrate.new
      migrate.execute_all_migrations(:up)
    end

    task "rollback" do
      migrate = BazaMigrations::Migrate.new
      migrate.execute_all_migrations(:down)
    end
  end
end
