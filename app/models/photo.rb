class Photo
  include Mongoid::Document

  field :image, type: String

  belongs_to :photoable, polymorphic: true

  mount_uploader :image, ImageUploader
  alias_method :url, :image_url

  def serializable_hash options = {}
    options ||= {}
    super({only: :type, methods: :url}.merge(options))
  end
end
