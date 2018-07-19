module ActiveAdmin
  class OrderClause

    def to_sql
      to_mongo_options
    end

    def to_mongo_options
      { @column => @order.downcase.to_sym }
    end

    def apply(chain)
      chain.reorder(sql)
    end
  end
end
