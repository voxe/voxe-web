class Candidate
  include Mongoid::Document

  field :firstName, type: String
  field :lastName, type: String

  has_and_belongs_to_many :elections
  has_many :propositions, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy, autosave: true

  validates_presence_of [:firstName, :lastName]

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  validates_associated :photos

  def name
    "#{firstName} #{lastName}"
  end
  
  def photo?
    !photos.blank?
  end
  
  def photo
    photos.first
  end

  def serializable_hash options = {}
    # super({methods: :elections}.merge(options))
    super options
  end

end
