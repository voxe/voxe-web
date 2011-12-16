class Tag
  include Mongoid::Document

  field :name,      type: String
  field :namespace, type: String
  field :icon,      type: String

  has_and_belongs_to_many :propositions

  before_validation :generate_namespace
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace

  mount_uploader :icon, IconUploader

  private

  def generate_namespace
    self.namespace = name.parameterize
  end

end
