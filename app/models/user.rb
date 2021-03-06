class User < ActiveRecord::Base
    has_many :posts, dependent: :destroy

    self.per_page = 10

  attr_accessor :remember_token
  before_save { self.email = email.downcase }


  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 111 },
        format: { with: VALID_EMAIL_REGEX }, 
        uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  ##Returns the hash digest of the given string(Listing8.18 RailsTut)
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end
  ## returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  ## remembers a user in the db for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  ## returns true if given token matches digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
