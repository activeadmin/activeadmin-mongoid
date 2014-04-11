module ActiveAdmin
  class OrderClause
    attr_reader :field, :order

    def initialize(clause)
      clause =~ /^([\w\_\.]+)_(desc|asc)$/
      @column = $1
      @order = $2

      @field = @column
    end

    def valid?
      @column.present? && @order.present?
    end

    def to_sql(options=nil)
      [@column, ' ', @order].compact.join
    end
  end
end
