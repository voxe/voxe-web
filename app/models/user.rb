class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  #
  # Attributes
  #
  field :admin,                type: Boolean, default: false
  field :name,                 type: String
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  #
  # Validations
  #
  validates_presence_of :name

  #
  # Associations
  #
  has_and_belongs_to_many :elections

  #
  # Callbacks
  #
  before_create :reset_authentication_token


end
