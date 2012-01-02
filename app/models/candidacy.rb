class Candidacy
  include Mongoid::Document

  #
  # Attributes
  #
  field :published, type: Boolean, default: false

  #
  # Associations
  #
  belongs_to :election
  belongs_to :organization
  has_many   :propositions
  has_and_belongs_to_many :candidates

  #
  # Validations
  #
  validates_presence_of :election

  #
  # Scopes
  #
  scope :published, where(published: true)

end