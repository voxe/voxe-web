class Proposition
  include MongoMapper::Document

  key :text, String

  belongs_to :candidate
  belongs_to :theme
  belongs_to :election

  validates_presence_of :text

end
