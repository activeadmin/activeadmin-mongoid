require 'delegate'
require 'meta_search/searches/mongoid'

module ActiveAdmin::Mongoid::Document
  extend ActiveSupport::Concern




  # INSTANCE METHODS

  # Returns the column object for the named attribute.
  def column_for_attribute(name)
    self.class.columns_hash[name.to_s]
  end




  # PROXY CLASSES

  class ColumnWrapper < SimpleDelegator
    def type
      _super = super
      case _super
      when Moped::BSON::ObjectId, Object
        :string
      else
        p _super.name.underscore.to_sym
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
    include MetaSearch::Searches::Mongoid

    unless respond_to? :primary_key
      class << self
        attr_accessor :primary_key
      end
    end

    self.primary_key ||= [:_id]

  end

  module ClassMethods

    # Metasearch

    def joins_values *args
      scoped
    end

    def group_by *args
      scoped
    end



    # Cache

    def [] name
      raise name.inspect
      cache[name]
    end

    def []= name, value
      cache[name]= value
    end

    def cache
      @cache ||= {}
    end


    # Columns

    def content_columns
      @content_columns ||= fields.map(&:second).reject do |f|
        f.name =~ /(^_|^(created|updated)_at)/ or Mongoid::Fields::ForeignKey === f
      end
    end

    def columns
      @columns ||= fields.map(&:second).map{ |c| ColumnWrapper.new(c) }
    end

    def column_names
      @column_names ||= fields.map(&:first)
    end

    def columns_hash
      columns.index_by(&:name)
    end



    def reorder *args
      scoped
    end

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
