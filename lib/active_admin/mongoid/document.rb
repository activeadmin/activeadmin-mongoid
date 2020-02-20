require 'delegate'

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
    unless respond_to? :primary_key
      class << self
        attr_accessor :primary_key
      end
    end

    self.primary_key ||= :id

    def column_for_attribute(name)
      self.class.fields[name.to_sym]
    end
  end

  module ClassMethods
    def content_columns
      # cannot cache this, since changes in time (while defining fields)
      fields.map(&:second).reject! do |f|
        f.name =~ /(^_|^(created|updated)_at)/ or Mongoid::Fields::ForeignKey === f
      end
    end

    def connection
      @connection ||= Connection.new(self)
    end

    def find_by_id id
      find_by(_id: id)
    end

    def quoted_table_name
      collection_name.to_s.inspect
    end

    def associations
      @associations ||= new.associations
    end

    def reflections *a
      relations *a
    end
  end
end

Mongoid::Document.send :include, ActiveAdmin::Mongoid::Document
