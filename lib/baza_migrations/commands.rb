class BazaMigrations::Commands
  path = "#{File.dirname(__FILE__)}/commands"

  autoload :AddIndex, "#{path}/add_index"
  autoload :Base, "#{path}/base"
  autoload :CreateTable, "#{path}/create_table"
  autoload :DropTable, "#{path}/drop_table"
  autoload :AddColumn, "#{path}/add_column"
  autoload :RemoveColumn, "#{path}/remove_column"
end
