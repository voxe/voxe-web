class Tag
  include Mongoid::Document

  field :name,      type: String
  field :namespace, type: String
  field :icon,      type: String

  validates_presence_of :name

  before_validation :on => :create do
    generate_namespace
  end

  validates_uniqueness_of :name, :namespace

  attr_protected :namespace

  mount_uploader :icon, IconUploader

  def icon_prefix
    "https://voxe.s3.amazonaws.com/tags/v2-#{namespace}_"
  end

  def icon_sizes
    [32, 64]
  end

  def icon_name
    ".png"
  end
  
  def to_s
    name
  end

  # returns all the elections this tag has been mentioned
  def elections
    ElectionTag.where tag: id
  end

  private
    def generate_namespace
      self.namespace = name.parameterize
    end

end
