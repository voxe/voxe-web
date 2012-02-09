class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Attributes
  #
  field :name,      type: String

  #
  # Associations
  #
  has_and_belongs_to_many :candidacies
  has_and_belongs_to_many :tags

  #
  # Validations
  #
  validates_inclusion_of :name, :in => %w( comparison )

end
