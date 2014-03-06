class Author
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post
  field :name
end
