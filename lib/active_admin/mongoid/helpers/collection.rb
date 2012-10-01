module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(collection=collection)
        if collection.count == 0
          0
        else
          collection.count(true)
        end
      end
    end
  end
end
