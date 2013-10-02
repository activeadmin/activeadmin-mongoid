ActiveAdmin.register Post do
  config.per_page = 30

  filter :title
  filter :body
  filter :created_at, as: :date_range
  filter :view_count, as: :numeric
  filter :admin_user, as: :select
  filter :other_user, as: :check_boxes

end
