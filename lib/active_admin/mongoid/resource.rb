require 'active_admin'
require 'inherited_resources'

ActiveAdmin::Resource # autoload
class ActiveAdmin::Resource
  original_resource_table_name = instance_method(:resource_table_name)

  define_method(:resource_table_name) do
    if(resource_class.included_modules.include? Mongoid::Document)
      return resource_class.collection_name
    else
      return original_resource_table_name.bind(self).()
    end
  end
end

ActiveAdmin::ResourceController # autoload
class ActiveAdmin::ResourceController
#  before_filter :skip_sidebar!

  protected

  # def skip_sidebar!
  #   @skip_sidebar = true
  # end

  original_sort_order = instance_method(:sort_order)

  # Use #desc and #asc for sorting.
  define_method(:sort_order) do |chain|
    if(chain.included_modules.include? Mongoid::Document)
      params[:order] ||= active_admin_config.sort_order
      table_name = active_admin_config.resource_table_name
      if params[:order] && params[:order] =~ /^([\w\_\.]+)_(desc|asc)$/
        chain.send($2, $1)
      else
        chain # just return the chain
      end
    else
      original_sort_order.bind(self).(chain)
    end      
  end

  original_search = instance_method(:search)

  # Disable filters
  define_method(:search) do |chain|
    if(chain.included_modules.include? Mongoid::Document)
      chain
    else
      original_search.bind(self).(chain)
    end
  end
end
