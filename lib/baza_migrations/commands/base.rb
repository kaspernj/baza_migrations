class BazaMigrations::Commands::Base
  attr_accessor :db, :table

  def default_args(args = {})
    return_args = {null: true}
    return_args[:null] = args[:null] if args.include?(:null)
    return_args[:default] = args[:default] if args.include?(:default)

    return_args
  end
end
