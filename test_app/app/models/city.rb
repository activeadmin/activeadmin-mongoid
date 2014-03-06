class City
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :author
  field :name
end
