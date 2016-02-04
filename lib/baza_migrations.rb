require "baza"
require "auto_autoloader"

class BazaMigrations
  AutoAutoloader.autoload_sub_classes(self, __FILE__)

  def self.load_tasks
    load "#{File.dirname(__FILE__)}/tasks/baza.rake"
  end
end
