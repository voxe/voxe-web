class Theme
  include MongoMapper::Document

  key :name, String
  key :icon, String

  many :propositions

  def elections
    # TODO Is it possible ?
  end

end
