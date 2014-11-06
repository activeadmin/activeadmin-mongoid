module ActiveAdmin
  module Filters
    module FormtasticAddons

      # The resource class, unwrapped from Ransack
      def klass
        @object.klass
      end

    end
  end
end
