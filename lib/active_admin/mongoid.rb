require 'rails'
require 'devise'
require 'mongoid'
require 'active_admin/mongoid/version'
require 'active_support/core_ext' # needed by ransack
require 'active_admin'

require 'active_admin/mongoid/filters/view_helper'
require 'active_admin/mongoid/helpers/collection'
require 'active_admin/mongoid/adaptor'
require 'active_admin/mongoid/comments'
require 'active_admin/mongoid/criteria'
require 'active_admin/mongoid/document'
require 'active_admin/mongoid/filter_form_builder'
require 'active_admin/mongoid/order_clause'
require 'active_admin/mongoid/resource'

module ActiveAdmin
  module Mongoid
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        require 'active_admin/mongoid/resource_controller/data_access'
        I18n.backend.reload!
      end
    end
  end

  # class << self
  #   alias setup_without_mongoid setup
  #
  #   # Load monkey patches *after* the setup process
  #   def setup *args, &block
  #     setup_without_mongoid *args, &block
  #
  #   end
  # end
end
