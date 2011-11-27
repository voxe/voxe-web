class Election
  include Mongoid::Document

  field :name, type: String

  has_and_belongs_to_many :candidates
  has_many :themes
  has_many :propositions

  validates_presence_of :name

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

end
