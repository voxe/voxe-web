class Candidate
  include Mongoid::Document
  include Mongoid::FullTextSearch

  # attributes
  field :first_name, type: String
  field :last_name, type: String
  field :namespace, type: String
  alias :firstName :first_name
  alias :lastName :last_name

  # relations
  has_and_belongs_to_many :candidacies, dependent: :destroy
  has_many :propositions, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy, autosave: true

  # validations
  validates_presence_of :namespace, :last_name
  validates_associated :photos
  validates_uniqueness_of :namespace

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  default_scope order_by([[:first_name, :asc], [:last_name, :desc]])

  def name
    "#{first_name} #{last_name}"
  end
  fulltext_search_in :name

  def photo?
    !photos.blank?
  end

  def photo
    photos.first
  end

  def photo_url(size = nil)
    #photo? ? ((size == nil) ? photo.image.url : photo.image.send(size).url) : default_photo(size)
    width = {:small => 50, :medium => 100, :large => 300}[size]
    "https://voxe.s3.amazonaws.com/candidates/#{namespace}-#{width}.jpg"
  end

  def to_s
    name
  end

  private

    def default_photo(size)
      "/images/candidate_#{size}.jpg".to_url
    end

end
