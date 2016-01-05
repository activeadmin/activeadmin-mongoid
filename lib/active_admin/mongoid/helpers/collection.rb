module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(_collection=collection)
        _collection.count
      end
    end
  end
end
