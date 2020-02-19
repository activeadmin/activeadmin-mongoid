module ActiveAdmin
  class Resource

    # the commit: https://github.com/activeadmin/activeadmin/commit/1ef08af5044814c336917fa93aea607dce16dcb7
    #  adds in the _id field, which doesn't work with ransack for some reason or
    #  another.  I'm not going to investigate any deeper, let's just remove the
    #  underscore prefixed fields as was the prior behavior
    def default_filters
      super.reject { |filter| filter == :_id }
    end

    module Attributes

      # Hardcode mongoid STI column name
      # see https://github.com/activeadmin/activeadmin/commit/1ef08af5044814c336917fa93aea607dce16dcb7#diff-e15d78c0b6b12c8bffec0de0ffcf735bR34
      def sti_col?(c)
        c.name == '_type'
      end

    end
  end
end
