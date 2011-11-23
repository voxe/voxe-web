class Theme
  include MongoMapper::Document
  plugin MongoMapper::Plugins::SortableItem

  key :name, String
  key :parentThemeId, String

  belongs_to :election
  belongs_to :theme, foreign_key: :parentThemeId
  many :themes, foreign_key: :parentThemeId
  many :propositions
  many :photos, as: :photoable

  validates_presence_of :name

  def serializable_hash options = {}
    super({include: [:themes, :propositions]}.merge(options))
  end

end
