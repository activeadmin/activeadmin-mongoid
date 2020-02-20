require 'active_admin/resource/attributes'

module ActiveAdmin

  class Resource
    module Attributes
      def foreign_methods
        @foreign_methods ||= resource_class.reflect_on_all_associations.
          select { |r| r.macro == :belongs_to }.
          index_by { |r| r.foreign_key.to_sym }
      end

      def primary_col?(c)
        c.name == '_id'
      end

      def sti_col?(c)
        false
      end
    end
  end
end
