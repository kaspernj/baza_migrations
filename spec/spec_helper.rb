$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rspec"
require "baza_migrations"
require "pry"
require "tmpdir"

if RUBY_PLATFORM == "java"
  require "jdbc/sqlite3"
  Jdbc::SQLite3.load_driver
else
  require "sqlite3"
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
