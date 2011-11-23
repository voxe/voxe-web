class Election
  include MongoMapper::Document

  key :name, String
  key :candidateIds, Array

  many :candidates, in: :candidateIds
  many :themes

  validates_presence_of :name

  def serializable_hash options = {}
    super({
      only:    [:id, :name],
      include: {candidates: {only: [:id, :firstName, :lastName, :photos]}},
      methods: [:themes]
    }.merge(options))
  end

end
