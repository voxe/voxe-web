class Election
  include Mongoid::Document

  field :name, type: String

  has_and_belongs_to_many :candidates
  has_many :themes, dependent: :destroy, autosave: true
  has_many :propositions

  validates_presence_of :name

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

end
