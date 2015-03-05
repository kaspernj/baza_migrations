class BazaMigrations::Commands::DropTable < BazaMigrations::Commands::Base
  def initialize(name)
    @name = name
  end

  def sql
    ["DROP TABLE `#{@name}`"]
  end

  def changed_rollback_sql
    raise BazaMigrations::Errors::IrreversibleMigration
  end
end
