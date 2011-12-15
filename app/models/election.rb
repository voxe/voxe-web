class Election
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  
  # relations
  belongs_to :country
  has_and_belongs_to_many :candidates
  has_many :propositions
  
  # validations
  before_validation :generate_namespace
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace

  def serializable_hash options = {}
    options ||= {}
    super({
      only:    [:_id, :name],
      include: {
        candidates: {only: [:_id, :firstName, :lastName, :photos]},
        propositions: {}
      }
    }.merge(options))
  end
  
  def to_param
    namespace
  end
  
  private
    def generate_namespace
      self.namespace = "#{name}".parameterize
    end

end
