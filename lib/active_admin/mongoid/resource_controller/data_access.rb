module ActiveAdmin
  class ResourceController < BaseController
    module DataAccess
      protected

      def collection
        get_collection_ivar || begin
          conditions = params[:q].nil? ? {} : params[:q].clone
          convert_date_conditions!(conditions)
          collection = find_collection.where(conditions)
          authorize! Authorization::READ, active_admin_config.resource_class
          set_collection_ivar collection
        end
      end

      private

      def convert_date_conditions!(conditions)
        if conditions.is_a?(Hash)
          delete_keys = []
          date_conditions = {}
          conditions.each do |key, value|
            if !resource_class.fields[key].nil? && resource_class.fields[key].type == DateTime
              date_conditions.merge!({key.to_sym.gte => DateTime.parse(value).beginning_of_day, key.to_sym.lte => DateTime.parse(value).end_of_day})
              delete_keys << key
            end
          end
          conditions.delete(delete_keys)
          conditions.merge!(date_conditions)
        end
      end
    end
  end
end
