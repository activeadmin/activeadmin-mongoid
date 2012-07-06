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

  # Use #desc and #asc for sorting.
  def sort_order(chain)
    params[:order] ||= active_admin_config.sort_order
    # @todo remove once https://github.com/mongoid/mongoid/pull/2175 is fixed
    if params[:order] && params[:order] != 'id_desc' && params[:order] =~ /^([\w\_\.]+)_(desc|asc)$/
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
