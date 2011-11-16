class Candidate
  include MongoMapper::Document

  key :firstName, String
  key :lastName, String

  many :propositions
  many :photos, as: :photoable

  validates_presence_of [:firstName, :lastName]

  def elections
    Election.where(candidate_ids: self.id)
  end

end
