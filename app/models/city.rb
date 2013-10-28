class City
  include Mongoid::Document

  field :name
  has_many :elections
  index name: 1
end
