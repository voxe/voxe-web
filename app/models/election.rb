class Election
  include Mongoid::Document
  
  # attributes
  field :name, type: String
  field :namespace, type: String
  
  # relations
  belongs_to :country
  has_and_belongs_to_many :candidates
  has_many :themes, dependent: :destroy, autosave: true
  has_many :propositions
  
  # validations
  before_validation :generate_namespace
  validates_presence_of :name, :namespace
  validates_uniqueness_of :namespace

  accepts_nested_attributes_for :themes, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }

  def serializable_hash options = {}
    options ||= {}
    super({
      only:    [:_id, :name],
      include: {
        candidates: {only: [:_id, :firstName, :lastName, :photos]},
        propositions: {}
      },
      methods: [:themes]
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
