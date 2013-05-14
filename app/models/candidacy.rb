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
  belongs_to :owner, class_name: 'User'

  #
  # Validations
  #
  validates_presence_of :election

  #
  # Scopes
  #
  scope :published, where(published: true)
  
  # TODO: remove temp hack
  def name
    candidates[0].try(:name)
  end
  
  # TODO: remove temp hack
  def namespace
    candidates[0].try(:namespace)
  end

  def photo_url(version)
    candidates[0].try(:photo_url, version)
  end

end
