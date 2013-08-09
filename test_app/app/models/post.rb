class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :body
  field :view_count, type: ::Integer, default: 0
  belongs_to :admin_user
  belongs_to :other_user, class_name: 'AdminUser'
end
