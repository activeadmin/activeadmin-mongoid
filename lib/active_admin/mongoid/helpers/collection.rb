module ActiveAdmin
  module Helpers
    module Collection

      alias original_collection_size collection_size
      original_collection_size = instance_method(:collection_size)

      def collection_size(collection=collection)
        if collection.is_a?(::Mongoid::Criteria)
          collection.count(true)
        else
          original_collection_size(collection)
        end
      end

    end
  end
end
