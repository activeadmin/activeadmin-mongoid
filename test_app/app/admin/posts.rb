ActiveAdmin.register Post do
  config.per_page = 30

  filter :title
  filter :body
  filter :view_count, as: :numeric
  filter :admin_user, as: :select
  filter :other_user, as: :check_boxes
  filter :created_at, as: :date_range

  permit_params :title, :body, :created_at, :view_count, :admin_user, :other_user
end
