require 'active_admin'

module ActiveAdmin
  module Mongoid
  end
  
  class << self
    alias setup_without_mongoid setup
    
    # Load monkey patches *after* the setup process
    def setup *args, &block
      setup_without_mongoid *args, &block
      
      require 'active_admin/mongoid/comments'
      require 'active_admin/mongoid/form_builder'
      require 'active_admin/mongoid/resource'
      require 'active_admin/mongoid/document'
    end
  end
end
