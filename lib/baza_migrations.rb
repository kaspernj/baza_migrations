require "baza"

class BazaMigrations
  autoload :Commands, "#{File.dirname(__FILE__)}/baza_migrations/commands"
  autoload :Errors, "#{File.dirname(__FILE__)}/baza_migrations/errors"
  autoload :Migration, "#{File.dirname(__FILE__)}/baza_migrations/migration"
end
