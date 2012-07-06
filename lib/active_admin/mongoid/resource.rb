require 'active_admin'
require 'inherited_resources'

ActiveAdmin::Resource # autoload
class ActiveAdmin::Resource
  def resource_table_name
    resource_class.collection_name
  end
end

ActiveAdmin::ResourceController # autoload
class ActiveAdmin::ResourceController
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
    @search = ActiveAdmin::Mongoid::Adaptor::Search.new(chain, clean_search_params(params[:q]))
  end

end
