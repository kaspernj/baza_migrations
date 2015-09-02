class BazaMigrations::Commands::CreateTable < BazaMigrations::Commands::Base
  def initialize(name)
    @name = name

    @columns = []
    @columns << {name: :id, type: :int, autoincr: true, primarykey: true}
  end

  def string(name)
    @columns << {name: name, type: :string, null: true}
  end

  def integer(name)
    @columns << {name: name, type: :int, null: true}
  end

  def timestamps
    @columns << {name: :created_at, type: :datetime, null: true}
    @columns << {name: :updated_at, type: :datetime, null: true}
  end

  def sql
    db.tables.create(@name, {columns: @columns}, {return_sql: true})
  end

  def changed_rollback_sql
    ["DROP TABLE `#{@name}`"]
  end
end
