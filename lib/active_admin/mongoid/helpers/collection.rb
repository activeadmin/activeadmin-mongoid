module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(collection=collection)
        collection.count(true)
      end
    end
  end
end
