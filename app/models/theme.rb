class Theme
  include MongoMapper::Document

  key :name, String

  many :propositions
  many :photos, :as => :photoable

  validates_presence_of :name

  def elections
    # TODO Is it possible ?
  end

end
