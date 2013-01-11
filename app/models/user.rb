class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable, :timeoutable :omniauthable and :registerable
  devise :database_authenticatable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  #
  # Attributes
  #

  ## Database authenticatable
  field :email,              :type => String, :default => ''
  field :encrypted_password, :type => String, :default => ''

  # Token authenticatable
  field :authentication_token, :type => String

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :admin,                type: Boolean, default: false
  field :name,                 type: String
  field :facebook_uid,         type: String
  field :facebook_token,       type: String
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :facebook_uid, :facebook_token
  index({ facebook_uid: 1 }, { background: true })

  #
  # Validations
  #
  validates_presence_of :name

  #
  # Associations
  #
  has_and_belongs_to_many :elections
  has_and_belongs_to_many :ambassador_elections, class_name: 'Election', inverse_of: :ambassadors
  has_and_belongs_to_many :contributor_elections, class_name: 'Election', inverse_of: :contributors

  #
  # Callbacks
  #
  before_create :reset_authentication_token
  after_destroy :destroy_proposition_comments!

  def self.find_for_facebook_token access_token
    begin
      graph   = Koala::Facebook::API.new(access_token)
      profile = graph.get_object("me")
    rescue Koala::Facebook::APIError => e
      return
    end
    return unless profile['email'].present?

    if user = User.where(facebook_uid: profile['id']).first
      # Do nothing
    elsif user = User.where(email: profile['email']).first
      # user already registered, add facebook uid
      user.facebook_uid = profile['id']
    else
      user = User.new facebook_uid: profile['id'],
        password: Devise.friendly_token[0,20]
    end

    user.facebook_token = access_token
    user.email = profile['email']
    user.name  = profile['name']

    user.save ? user : nil
  end
  
  # picture
  def picture?
    !facebook_uid.blank?
  end
  
  def picture
    "http://graph.facebook.com/#{facebook_uid}/picture?type=square"
  end

  def proposition_comments
    Proposition.where("comments.user_id" => self.id).collect(&:comments).flatten
  end

  private

  def destroy_proposition_comments!
    proposition_comments.map(&:destroy)
  end
end
