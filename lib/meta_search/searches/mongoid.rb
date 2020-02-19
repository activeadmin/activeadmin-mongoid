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
        @params = params
        @options = options
      end

      def build
        params.each_pair do |field_query, value|
          field, query = field_query.to_s.scan(metasearch_regexp).first
          case query.to_sym
          when :equals, :eq
            @relation = relation.where(field => value)
          when :does_not_equal, :ne, :not_eq
            @relation = relation.where(field.to_sym.ne => value)
          when :contains, :like, :matches
            @relation = relation.where(field => /#{value}/i)
          when :does_not_contain, :nlike, :not_matches
            @relation = relation.where(field.to_sym.not => /#{value}/i)
          when :starts_with, :sw
            @relation = relation.where(field.to_sym => /\A#{Regexp.quote(value)}/i)
          when :does_not_start_with, :dnsw
            @relation = relation.where(field.to_sym.not => /\A#{Regexp.quote(value)}/i)
          when :ends_with, :ew
            @relation = relation.where(field.to_sym => /#{Regexp.quote(value)}\z/i)
          when :does_not_end_with, :dnew
            @relation = relation.where(field.to_sym.not => /#{Regexp.quote(value)}\z/i)
          when :greater_than, :gt
            @relation = relation.where(field.to_sym.gt => value)
          when :less_than, :lt
            @relation = relation.where(field.to_sym.lt => value)
          when :greater_than_or_equal_to, :gte, :gteq
            @relation = relation.where(field.to_sym.gte => value)
          when :less_than_or_equal_to, :lte, :lteq
            @relation = relation.where(field.to_sym.lte => value)
          when :in
            @relation = relation.where(field.to_sym.in => Array.wrap(value))
          when :not_in, :ni
            @relation = relation.where(field.to_sym.nin => Array.wrap(value))
          when :is_true
            @relation = relation.where(field => true)
          when :is_false
            @relation = relation.where(field => false)
          when :is_present
            @relation = relation.where(field.to_sym.exists => true)
          when :is_blank
            @relation = relation.where(field.to_sym.exists => false)
          when :is_null
            @relation = relation.where(field => nil)
          when :is_not_null
            @relation = relation.where(field.to_sym.ne => nil)
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
        field_names = klass.fields.map { |field| field.second.name }
        conditions = MetaSearch::DEFAULT_WHERES.map { |condition| condition[0...-1] } # pop tail options

        /\A(#{field_names.join('|')})_(#{conditions.join('|')})\z/
      end

    end

    module Mongoid
      extend ActiveSupport::Concern

      module ClassMethods
        def metasearch(params = nil, options = nil)
          options ||= {}
          params  ||= {}
          MongoidSearchBuilder.new(criteria, params, options).build
        end
        alias_method :search, :metasearch unless respond_to?(:search)
      end

    end
  end
end
