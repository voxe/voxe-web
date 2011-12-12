class Candidate
  include Mongoid::Document

  # attributes
  field :firstName, type: String
  field :lastName, type: String
  field :namespace, type: String
  
  # relations
  has_and_belongs_to_many :elections
  has_many :propositions, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy, autosave: true

  # validations
  before_validation :generate_namespace
  validates_presence_of [:firstName, :lastName, :namespace]
  validates_associated :photos
  validates_uniqueness_of :namespace
  
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  def name
    "#{firstName} #{lastName}"
  end
  
  def photo?
    !photos.blank?
  end
  
  def photo
    photos.first
  end
  
  def photo_url(size = nil)
    photo? ? ((size == nil) ? photo.image.url : photo.image.send(size).url) : default_photo(size)
  end

  def serializable_hash options = {}
    # super({methods: :elections}.merge(options))
    super options
  end
  
  private
    def generate_namespace
      self.namespace = "#{firstName}-#{lastName}".parameterize
    end
    
    def default_photo(size)
      "/images/candidate_#{size}.jpg".to_url
    end

end