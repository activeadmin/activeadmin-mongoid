require 'active_admin/filters/active_filter'
module ActiveAdmin
  module Filters

    class ActiveFilter
      def related_primary_key
        if predicate_association
          predicate_association.key
        elsif related_class
          related_class.key
        end
      end
    end
  end
end
