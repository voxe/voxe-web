class CandidacyCandidateProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  # attributes
  field :name, type: String
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

  attr_accessor :password

  # relations
  belongs_to :candidacy
  belongs_to :user

  after_create :generate_user

  private

  def generate_user
    self.create_user email: self.email, password: self.password, password_confirmation: self.password, name: self.name
    save
  end

end
