class Proposition
  include MongoMapper::Document

  key :text,        String
  key :candidateId, String
  key :themeId,     String
  key :electionId,  String

  belongs_to :candidate, foreign_key: :candidateId
  belongs_to :theme,     foreign_key: :themeId
  belongs_to :election,  foreign_key: :electionId

  validates_presence_of :candidate, :theme, :election, :text

end
