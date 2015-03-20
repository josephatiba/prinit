class User
  include Mongoid::Document
  has_many :posts

  has_many :orders


  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :password, presence: true, length: { in: 2..20 }, confirmation: true, on: [:create, :update] # :if => :password, :unless => :password_digest.present?

  validates :first_name, presence: true

  validates :last_name, presence: true

  attr_reader :password, :password_confirmation

  field :username, type: String
  field :email, type: String  
  field :user_id, type: String  
  field :password_digest, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :category, type: String
  field :bio, type: String
  field :contact_info, type: String 

  mount_uploader :prof_pic, PictureUploader


  def password=(unencrypted_password)
    unless unencrypted_password.empty?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  # a new method to authenticate a user

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end

  def email
    self[:email]
  end


end
