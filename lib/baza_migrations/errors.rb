class BazaMigrations::Errors
  class NotImplementedError < RuntimeError; end
  class IrreversibleMigration < RuntimeError; end
end
