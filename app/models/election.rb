class Election
  include MongoMapper::Document

  key :name, String
  key :candidate_ids, Array
  key :theme_ids, Hash

  many :candidates, in: :candidate_ids

  validates_presence_of :name

  def themes
    Theme.find(theme_ids.keys)
  end

  def sub_themes
    Theme.find(theme_ids.values.flatten)
  end

  def sub_themes_of theme_id
    Theme.find theme_ids[theme_id]
  end

end
