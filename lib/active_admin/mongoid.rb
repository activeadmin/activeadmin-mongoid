require 'active_admin/mongoid/version'
require 'active_model'
require 'mongoid'
require 'ransack'
require 'kaminari/mongoid'
# require 'active_admin/mongoid/engine'
require 'active_admin'
require 'devise'
require 'rails'

# require 'active_admin/mongoid/comments'
# require 'active_admin/mongoid/adaptor' # This appears to no longer be used.
require 'active_admin/mongoid/filter_form_builder'
require 'active_admin/mongoid/resource'
require 'active_admin/mongoid/document'
require 'active_admin/mongoid/helpers/collection'
require 'active_admin/mongoid/criteria'
require 'active_admin/mongoid/order_clause'

require 'active_admin/mongoid/inputs/filters/check_boxes_input'
require 'active_admin/mongoid/inputs/filters/select_input'
require 'active_admin/mongoid/filters/active_filter'
require 'active_admin/mongoid/filters/resource_extension'
require 'active_admin/mongoid/controllers/resource_controller'
require 'active_admin/mongoid/resource/attributes'
require 'active_admin/mongoid/csv_builder'

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
