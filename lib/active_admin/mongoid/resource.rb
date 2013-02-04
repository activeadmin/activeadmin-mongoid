require 'active_admin'
require 'inherited_resources'

ActiveAdmin::Resource # autoload
class ActiveAdmin::Resource
  def resource_table_name
    resource_class.collection_name
  end

  def mongoid_per_page
    per_page
  end
end

ActiveAdmin::ResourceController # autoload
class ActiveAdmin::ResourceController

  protected

  # Use #desc and #asc for sorting.
  def sort_order(chain)
    params[:order] ||= active_admin_config.sort_order
    table_name = active_admin_config.resource_table_name
    if params[:order] && params[:order] =~ /^([\w\_\.]+)_(desc|asc)$/
      chain.send($2, $1)
    else
      chain # just return the chain
    end
  end

  def search(chain)
    @search = ActiveAdmin::Mongoid::Adaptor::Search.new(chain, clean_search_params(params[:q]), active_admin_config.mongoid_per_page, params[:page])
  end
end
