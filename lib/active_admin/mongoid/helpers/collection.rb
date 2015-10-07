module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(_collection=collection)
        _collection.count(true)
      end
    end
  end
end
