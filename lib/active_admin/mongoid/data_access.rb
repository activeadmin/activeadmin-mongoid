ActiveAdmin::ResourceController::DataAccess.class_eval do
  def apply_sorting(chain)
    params[:order] ||= active_admin_config.sort_order
    if params[:order] && params[:order] =~ /^([\w\_\.]+)_(desc|asc)$/
      column = $1
      order  = $2
      chain.send(order, column)
    else
      chain # just return the chain
    end
  end


  def apply_filtering(chain)
    @search = ActiveAdmin::Mongoid::Search.new(chain, clean_search_params(params[:q]), active_admin_config.per_page, params[:page])
  end
end
