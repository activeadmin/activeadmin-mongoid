ActiveAdmin::Resource # autoload
class ActiveAdmin::Resource
  def resource_table_name
    resource_class.collection_name
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
