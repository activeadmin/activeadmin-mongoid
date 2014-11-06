require 'active_admin/mongoid/version'
require 'active_model'
require 'mongoid'
require 'ransack'
# require 'active_admin/mongoid/engine'
require 'active_admin'
require 'devise'
require 'rails'

# require 'active_admin/mongoid/comments'
require 'active_admin/mongoid/adaptor'
require 'active_admin/mongoid/filter_form_builder'
require 'active_admin/mongoid/resource'
require 'active_admin/mongoid/document'
require 'active_admin/mongoid/helpers/collection'
require 'active_admin/mongoid/criteria'

require 'active_admin/mongoid/order_clause'
require 'active_admin/mongoid/filters/formtastic_addons'

module ActiveAdmin
  module Mongoid
    class Railtie < ::Rails::Railtie
      config.after_initialize do
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
