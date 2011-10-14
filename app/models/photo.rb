class Photo
  require 'carrierwave/orm/mongomapper'
  include MongoMapper::EmbeddedDocument

  key :image, String
  key :type, String

  belongs_to :photoable

  mount_uploader :image, ImageUploader
  alias_method :url, :image_url

  validates_presence_of :image
  validates_inclusion_of :type, :in => %w( square )

  def serializable_hash options = {}
    super({only: :type, methods: :url}.merge(options))
  end
end
