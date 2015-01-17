module ActiveAdmin
  class ResourceController < BaseController

    module DataAccess

      # Applies any Ransack search methods to the currently scoped collection.
      # Both `search` and `ransack` are provided, but we use `ransack` to prevent conflicts.
      def apply_filtering(chain)
        @search = chain.where RansackMongo::Query.parse clean_search_params params[:q]
      end
    end
  end
end
