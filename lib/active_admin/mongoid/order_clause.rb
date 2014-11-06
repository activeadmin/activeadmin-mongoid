module ActiveAdmin
  class OrderClause

    def to_sql(active_admin_config)
      to_mongo_options(active_admin_config)
    end

    def to_mongo_options(active_admin_config)
      { @column => @order.downcase.to_sym }
    end
  end
end
