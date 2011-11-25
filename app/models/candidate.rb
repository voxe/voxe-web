class Candidate
  include MongoMapper::Document

  key :firstName, String
  key :lastName, String

  many :propositions
  many :photos, as: :photoable

  validates_presence_of [:firstName, :lastName]

  def elections
    Election.where(candidateIds: self.id).all
  end

  def serializable_hash options = {}
    super({methods: :elections}.merge(options))
  end

end
