class CandidacyCandidateProfile
  include Mongoid::Document
  include Mongoid::FullTextSearch

  # attributes
  field :phone, type: String
  field :birthday, type: Date
  field :email, type: String
  field :address, type: String
  field :biography, type: String
  field :introduction, type: String
  field :twitter, type: String
  field :facebook, type: String
  field :youtube, type: String
  field :wikipedia, type: String
  field :website, type: String

  # relations
  belongs_to :candidacy

end
