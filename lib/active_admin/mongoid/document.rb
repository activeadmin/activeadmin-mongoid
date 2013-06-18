module ActiveAdmin::Mongoid::Document
  extend ActiveSupport::Concern

  included do
    unless respond_to? :primary_key
      class << self
        attr_accessor :primary_key
      end
    end

    self.primary_key ||= [:_id]
  end

  class Connection
    def initialize model
      @model = model
    end

    def quote_column_name name
      name
    end
  end

  module ClassMethods
    def content_columns
      @content_columns ||= fields.map(&:second).select {|f| f.name !~ /(^_|^(created|updated)_at)/}
    end

    def metasearch *args, &block
      scoped
    end

    def columns
      @columns ||= fields.map(&:second)
    end

    def column_names
      @column_names ||= fields.map(&:first)
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

  end
end

Mongoid::Document.send :include, ActiveAdmin::Mongoid::Document
