class Country
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  
  # relations
  has_many :elections
  
  # validations
  before_validation :generate_namespace
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
