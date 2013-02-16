require 'active_admin/mongoid/version'
# require 'active_admin/mongoid/engine'
require 'active_admin'
require 'mongoid'

module ActiveAdmin
  module Mongoid
  end

  class << self
    alias setup_without_mongoid setup

    # Load monkey patches *after* the setup process
    def setup *args, &block
      setup_without_mongoid *args, &block

      require 'active_admin/mongoid/adaptor'
      require 'active_admin/mongoid/comments'
      require 'active_admin/mongoid/filter_form_builder'
      require 'active_admin/mongoid/resource'
      require 'active_admin/mongoid/document'
      require 'active_admin/mongoid/helpers/collection'
    end
  end
end
