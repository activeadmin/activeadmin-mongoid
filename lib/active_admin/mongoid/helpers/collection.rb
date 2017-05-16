module ActiveAdmin
  module Helpers
    module Collection
      def collection_size(c=collection)
        if(not c.empty? and c.first.class.included_modules.include?(Mongoid::Document))
          if c.first.class.embedded?
            c.count
          else
            c.count(true)
          end
        else
          c.count
        end
      end
    end
  end
end
