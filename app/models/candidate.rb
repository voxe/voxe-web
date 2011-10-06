class Candidate
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String

  many :propositions

  def elections
    Election.where(:candidate_ids => self.id)
  end

end
