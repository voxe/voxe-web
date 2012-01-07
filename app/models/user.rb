class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #
  # Attributes
  #
  field :admin, type: Boolean, default: false
  field :name, type: String
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  #
  # Validations
  #
  validates_presence_of :name

  #
  # Associations
  #
  has_and_belongs_to_many :elections



end
