class Candidate
  include Mongoid::Document

  field :firstName, type: String
  field :lastName, type: String

  has_and_belongs_to_many :elections
  has_many :propositions
  has_many :photos, as: :photoable

  validates_presence_of [:firstName, :lastName]
  
  def name
    "#{firstName} #{lastName}"
  end

  def serializable_hash options = {}
    # super({methods: :elections}.merge(options))
    super options
  end

end
