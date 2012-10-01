module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(collection=collection)
        collection.count(true)
      rescue
        collection.count
      end
    end
  end
end
