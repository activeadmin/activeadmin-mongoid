class Author
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post
  embeds_one :city

  field :name
end
