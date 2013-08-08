require 'active_support/concern'
require 'meta_search/method'
require 'meta_search/builder'

module MetaSearch
  module Searches

    require 'delegate'
    class MongoidSearchBuilder < SimpleDelegator
      def initialize relation, params, options
        super(relation)
        @relation = relation
        @params, @options = params, options
      end

      def build
        params.each_pair do |field_query, value|
          field, query = field_query.scan(metasearch_regexp).first
          case query.to_sym
          when :contains
            @relation = relation.where(field => /#{value}/)
          else
            raise [field_query, value].inspect
          end
        end
        self
      end

      attr_reader :relation, :params, :options

      def base
        self
      end

      def klass
        relation
      end

      def method_missing name, *attrs, &block
        relation.send(name, *attrs, &block)
      end


      def respond_to? name, include_private = false
        name.to_s =~ metasearch_regexp or super
      end

      def method_missing name, *args, &block
        if name =~ metasearch_regexp
          params[name]
        else
          super
        end
      end

      def metasearch_regexp
        field_names = klass.content_columns.map(&:name)

        conditions = MetaSearch::DEFAULT_WHERES.map {|condition| condition[0...-1]} # pop tail options

        /\A(#{field_names.join('|')})_(#{conditions.join('|')})/
      end

    end

    module Mongoid
      extend ActiveSupport::Concern

      module ClassMethods
        def metasearch(params = nil, options = nil)
          options ||= {}
          params  ||= {}
          MongoidSearchBuilder.new(self, params, options).build
          # @metasearch_query
          # raise [params, options].inspect unless [options, params].all?(&:empty?)
          # scoped
        end
        alias_method :search, :metasearch unless respond_to?(:search)
      end

    end
  end
end
