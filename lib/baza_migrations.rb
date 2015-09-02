require "baza"

load "#{File.dirname(__FILE__)}/tasks/baza.rake" if ::Kernel.const_defined?(:Rake)

class BazaMigrations
  path = File.dirname(__FILE__)

  autoload :Commands, "#{path}/baza_migrations/commands"
  autoload :Errors, "#{path}/baza_migrations/errors"
  autoload :Migrate, "#{path}/baza_migrations/migrate"
  autoload :Migration, "#{path}/baza_migrations/migration"
  autoload :MigrationsExecutor, "#{path}/baza_migrations/migrations_executor"
end
