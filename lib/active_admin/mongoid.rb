require 'active_admin/mongoid/version'
# require 'active_admin/mongoid/engine'
require 'rails'
require 'mongoid'
require 'active_admin'

require 'active_admin/mongoid/comments'
require 'active_admin/mongoid/adaptor'
require 'active_admin/mongoid/filter_form_builder'
require 'active_admin/mongoid/resource'
require 'active_admin/mongoid/document'
require 'active_admin/mongoid/helpers/collection'
require 'active_admin/mongoid/criteria'

# # AA seems to add load_paths after the backend is already loaded.
# I18n.backend.reload!


# module ActiveAdmin
#   module Mongoid
#   end
#
#   class << self
#     alias setup_without_mongoid setup
#
#     # Load monkey patches *after* the setup process
#     def setup *args, &block
#       setup_without_mongoid *args, &block
#
#     end
#   end
# end
