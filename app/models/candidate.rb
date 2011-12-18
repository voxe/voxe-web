class Candidate
  include Mongoid::Document

  # attributes
  field :first_name, type: String
  field :last_name, type: String
  field :namespace, type: String
  
  # relations
  has_and_belongs_to_many :elections
  has_many :propositions, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy, autosave: true

  # validations
  before_validation :generate_namespace
  validates_presence_of [:first_name, :last_name, :namespace]
  validates_associated :photos
  validates_uniqueness_of :namespace
  
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  def name
    "#{first_name} #{last_name}"
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
  
  private
    def generate_namespace
      self.namespace = "#{first_name}-#{last_name}".parameterize
    end
    
    def default_photo(size)
      "/images/candidate_#{size}.jpg".to_url
    end

end