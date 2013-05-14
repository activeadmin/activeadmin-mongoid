# module ActiveAdmin
#   class Resource
#
#     module Naming
#
#       # Returns a name used to uniquely identify this resource
#       # this should be an instance of ActiveAdmin:Resource::Name, which responds to
#       # #singular, #plural, #route_key, #human etc.
#       def resource_name
#         custom_name = @options[:as] && @options[:as].gsub(/\s/,'')
#         @resource_name ||= if custom_name || !resource_class.respond_to?(:model_name)
#             Resource::Name.new(resource_class, custom_name)
#           else
#             Resource::Name.new(resource_class)
#           end
#       end
#
#     end
#
#   end
# end

# ActiveAdmin::Resource # autoload
# class ActiveAdmin::Resource
#   def resource_table_name
#     resource_class.collection_name
#   end
#
#   def mongoid_per_page
#     per_page
#   end
# end
#
# ActiveAdmin::ResourceController # autoload
# class ActiveAdmin::ResourceController
#
#   protected
#
#   # Use #desc and #asc for sorting.
#   def sort_order(chain)
#     params[:order] ||= active_admin_config.sort_order
#     if params[:order] && params[:order] =~ /^([\w\_\.]+)_(desc|asc)$/
#       chain.send($2, $1)
#     else
#       chain # just return the chain
#     end
#   end
#
#   def search(chain)
#     @search = ActiveAdmin::Mongoid::Search.new(chain, clean_search_params(params[:q]), active_admin_config.mongoid_per_page, params[:page])
#   end
# end
