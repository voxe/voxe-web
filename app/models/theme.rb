class Theme
  include Mongoid::Document
  include ActsAsList::Mongoid

  # attributes
  field :position,      type: Integer
  field :name,          type: String
  field :parentThemeId, type: String
  field :namespace, type: String
  
  # relations
  belongs_to :election
  belongs_to :theme, foreign_key: :parentThemeId
  has_many :themes, foreign_key: :parentThemeId, dependent: :destroy, autosave: true
  has_many :propositions, foreign_key: :themeId
  has_many :photos, as: :photoable
  
  acts_as_list column: :position
  
  # validation
  before_validation :generate_namespace
  validates_presence_of :name, :namespace
  # validates_uniqueness_of :namespace

  accepts_nested_attributes_for :themes, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  

  def self.parents
    Theme.where(parentThemeId: nil)
  end

  def sections
    return [] unless election.present?
    themes.map { |category| category.themes }.flatten
  end

  def serializable_hash options = {}
    options ||= {}
    super({include: :themes}.merge(options))
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
      self.namespace = "#{name}".parameterize
    end
    
    def default_photo(size)
      "/images/theme_#{size}.jpg".to_url
    end

end