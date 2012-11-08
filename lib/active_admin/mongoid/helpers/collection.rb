module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(collection=collection)
        collection.count()
      end
    end
  end
end
