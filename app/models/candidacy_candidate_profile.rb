class CandidacyCandidateProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  mount_uploader :picture, ProfileUploader

  # attributes
  field :name,          type: String
  field :phone,         type: String
  field :birthday,      type: Date
  field :email,         type: String
  field :address,       type: String
  field :postal_code,   type: String
  field :biography,     type: String
  field :introduction,  type: String
  field :twitter,       type: String
  field :facebook,      type: String
  field :youtube,       type: String
  field :wikipedia,     type: String
  field :website,       type: String
  field :cibul,         type: String

  attr_accessor :password

  # relations
  belongs_to :candidacy
  belongs_to :user

  validates_presence_of :name, :email, :phone
  validates_presence_of :password, on: :create

  after_create :generate_user
  after_update :notify_backoffice_created, if: "self.candidacy.present? and self.candidacy_id_changed?"

  private

  def generate_user
    self.create_user email: self.email, password: self.password, password_confirmation: self.password, name: self.name
    self.save
    UserMailer.backoffice_thank_you(self.user).deliver
    true
  end

  def notify_backoffice_created
    UserMailer.backoffice_confirmed(self.user).deliver
  end

end
