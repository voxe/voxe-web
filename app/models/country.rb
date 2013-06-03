class Country
  include Mongoid::Document
  include Mongoid::Slug
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  
  slug do |cur_object|
    cur_object.namespace || cur_object.name.parametrize
  end

  # relations
  has_many :elections
  
  # validations
  before_validation :generate_namespace, if: ->{ self.namespace.blank? }
  validates_presence_of :name, :namespace
  
  def to_param
    namespace
  end
  
  def to_s
    self.name
  end

  private
    def generate_namespace
      self.namespace = "#{name}".parameterize
    end
end
