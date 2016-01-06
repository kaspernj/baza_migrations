require "baza"
require "auto_autoloader"

load "#{File.dirname(__FILE__)}/tasks/baza.rake" if ::Kernel.const_defined?(:Rake)

class BazaMigrations
  AutoAutoloader.autoload_sub_classes(self, __FILE__)
end
