module ActiveAdmin
  module Filters
    module FormtasticAddons

      def searchable_has_many_through?
        false
      end

      def has_predicate?
        !!RansackMongo::Predicate.new(RansackMongo::MongoAdapter::PREDICATES).detect_from_string(method.to_s)
      end

      def ransacker?
        false
      end

      def scope?
        false
      end

    end
  end
end
