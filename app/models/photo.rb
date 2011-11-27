class Photo
  include Mongoid::Document

  field :image, type: String
  field :type, type: String

  belongs_to :photoable, polymorphic: true

  mount_uploader :image, ImageUploader
  alias_method :url, :image_url

  validates_presence_of :image
  validates_inclusion_of :type, in: %w( square )

  def serializable_hash options = {}
    options ||= {}
    super({only: :type, methods: :url}.merge(options))
  end
end
