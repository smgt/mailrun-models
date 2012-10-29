class User < ActiveRecord::Base

  has_one :user_information
  has_many :templates

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :api_key

  #
  # Use securerandom to generate api tokens
  # SecureRandom.urlsafe_base64

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

end
