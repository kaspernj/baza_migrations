class BazaMigrations::Commands::CreateTable < BazaMigrations::Commands::Base
  def initialize(name)
    @name = name

    @columns = []
    @columns << {name: :id, type: :int, autoincr: true, primarykey: true}
  end

  def string(name, args = {})
    @columns << {name: name, type: :string}.merge(default_args(args))
  end

  def text(name, args = {})
    @columns << {name: name, type: :text}.merge(default_args(args))
  end

  def integer(name, args = {})
    @columns << {name: name, type: :int}.merge(default_args(args))
  end

  def timestamps(args = {})
    @columns << {name: :created_at, type: :datetime}.merge(default_args(args))
    @columns << {name: :updated_at, type: :datetime}.merge(default_args(args))
  end

  def belongs_to(name, args = {})
    @columns << {name: "#{name}_id", type: :int, null: true}.merge(default_args(args))
  end

  def datetime(name, args = {})
    @columns << {name: name, type: :datetime}.merge(default_args(args))
  end

  def sql
    db.tables.create(@name, {columns: @columns}, return_sql: true)
  end

  def changed_rollback_sql
    ["DROP TABLE `#{@name}`"]
  end
end
