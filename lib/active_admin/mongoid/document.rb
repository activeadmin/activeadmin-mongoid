require 'delegate'
# require 'meta_search/searches/mongoid'

module ActiveAdmin::Mongoid::Document
  extend ActiveSupport::Concern




  # PROXY CLASSES

  class ColumnWrapper < SimpleDelegator
    def type
      _super = super
      case _super
      when BSON::ObjectId, Object
        :string
      else
        _super.name.underscore.to_sym
      end
    end
  end

  class Connection
    def initialize model
      @model = model
    end

    def quote_column_name name
      name
    end
  end




  # CLASS METHODS

  included do
    # include MetaSearch::Searches::Mongoid

    unless respond_to? :primary_key
      class << self
        attr_accessor :primary_key
      end
    end

    self.primary_key ||= :id

  end

  module ClassMethods

    # Metasearch

    # def joins_values *args
    #   criteria
    # end

    # def group_by *args, &block
    #   criteria
    # end

    # def ransack *args
    #   scoped

    #   scoped.class.class_eval do
    #     def result
    #       self
    #     end
    #   end

    #   scoped
    # end


    # Cache

    # def [] name
    #   raise name.inspect
    #   cache[name]
    # end

    # def []= name, value
    #   cache[name]= value
    # end

    # def cache
    #   @cache ||= {}
    # end


    # Columns

    # def content_columns
    #   # cannot cache this, since changes in time (while defining fields)
    #   fields.map(&:second).reject do |f|
    #     f.name =~ /(^_|^(created|updated)_at)/ or Mongoid::Fields::ForeignKey === f
    #   end
    # end

    # def columns
    #   @columns ||= fields.map(&:second).map{ |c| ColumnWrapper.new(c) }
    # end

    # def column_names
    #   @column_names ||= fields.map(&:first)
    # end

    # def columns_hash
    #   columns.index_by(&:name)
    # end



    # def reorder sorting
    #   return unscoped if sorting.blank?
    #   if sorting.match /\".*\".*/
    #     options = sorting.split(/ |\./)
    #     options.shift if options.count == 3
    #   else
    #     options = sorting.split(' ')
    #   end
    #   field, order = *options
    #   unscoped.order_by(field => order)
    # end

    def connection
      @connection ||= Connection.new(self)
    end

    def find_by_id id
      find_by(:_id => id)
    end

    def quoted_table_name
      collection_name.to_s.inspect
    end


    def reflections *a
      relations *a
    end
  end
end

Mongoid::Document.send :include, ActiveAdmin::Mongoid::Document
# Mongoid::Document.send :include, MetaSearch::Searches::Mongoid


