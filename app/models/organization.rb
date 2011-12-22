class Organization
  include Mongoid::Document

  #
  # Attributes
  #
  field :name, type: String

  #
  # Associations
  #
  has_many :candidacies

  #
  # Validations
  #
  validates_presence_of :name
  validates_uniqueness_of :name

end
