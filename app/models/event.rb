class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Attributes
  #
  field :name,          type: String
  field :ip_address,    type: String
  field :user_driven,   type: Boolean, default: false

  #
  # Associations
  #
  has_and_belongs_to_many :candidacies, inverse_of: nil
  has_and_belongs_to_many :tags, inverse_of: nil

  #
  # Validations
  #
  validates_inclusion_of :name, :in => %w( comparison )
  
  #
  # Indexes
  #
  index [[:name, Mongo::ASCENDING], [:created_at, Mongo::ASCENDING]]
  index [[:name, Mongo::ASCENDING], [:created_at, Mongo::DESCENDING]]

end
