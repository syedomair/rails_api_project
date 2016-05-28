class User < ActiveRecord::Base

  require "base64"

  attr_accessor :password
  attr_accessor :password_confirmation

  before_save :encrypt_password
  after_save :clear_password

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, email: true 
  

  def self.authenticate(email="", login_password="")
    user = User.find_by_email(email)
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   

  def match_password(login_password="")
    login_password = Base64.decode64(login_password);
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def encrypt_password
    unless password.blank?
      password1 = Base64.decode64(password);
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password1, salt)
    end
  end

  def clear_password
    self.password = nil
  end

end
