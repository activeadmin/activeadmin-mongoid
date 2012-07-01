require 'active_admin'
require 'inherited_resources'

ActiveAdmin::Resource # autoload
class ActiveAdmin::Resource
  def resource_table_name
    resource.collection_name
  end
end

ActiveAdmin::ResourceController # autoload
class ActiveAdmin::ResourceController
  before_filter :skip_sidebar!

  protected

  def skip_sidebar!
    @skip_sidebar = true
  end

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

  # Disable filters
  def search(chain)
    chain
  end
end
