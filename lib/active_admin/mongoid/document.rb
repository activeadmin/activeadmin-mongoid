module ActiveAdmin::Mongoid::Document
  extend ActiveSupport::Concern

  module ClassMethods
    def content_columns
      @content_columns ||= fields.map(&:second).select {|f| f.name !~ /(^_|^(created|updated)_at)/}
    end

    def columns
      @columns ||= fields.map(&:second)
    end

    def reorder *args
      scoped
    end

    def primary_key
      :_id
    end
  end
end

Mongoid::Document.send :include, ActiveAdmin::Mongoid::Document
