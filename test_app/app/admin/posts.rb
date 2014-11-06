ActiveAdmin.register Post do
  config.per_page = 30

  permit_params :title, :body

  filter :title
  filter :body
  filter :created_at, as: :date_range
  filter :view_count, as: :numeric
  filter :admin_user, as: :select
  filter :other_user, as: :check_boxes

  index do
    selectable_column
    column :title
    column :body
    column :view_count
    column 'Author Name', :'author.name' do |post|
      post.author.name if post.author.present?
    end
    column 'Author City Name', :'author.city.name' do |post|
      author = post.author
      author.city.name if author.present? and author.city.present?
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Post" do
      f.input :title
      f.input :body
    end
    f.actions
  end
end
