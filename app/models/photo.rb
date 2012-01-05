class Photo
  include Mongoid::Document

  # attributes
  field :image, type: String

  # relationships
  belongs_to :photoable, polymorphic: true

  mount_uploader :image, ImageUploader
  alias_method :url, :image_url

  #
  # Validation
  #
  validates_presence_of :image

end