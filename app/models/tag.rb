class Tag
  include Mongoid::Document

  field :name,      type: String
  field :namespace, type: String
  field :icon,      type: String

  has_and_belongs_to_many :propositions

  validates_presence_of :name, :namespace
  validates_uniqueness_of :name, :namespace

  mount_uploader :icon, IconUploader
  
  def icon_prefix
    "/images/tags/#{namespace}_".to_url
  end
  
  def icon_sizes
    [32, 64]
  end
  
  def icon_name
    ".png"
  end
  
  # returns all the elections this tag has been mentioned
  def elections
    ElectionTag.where tag: id
  end

end
