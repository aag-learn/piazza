class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }


  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  normalizes :name, with: -> (name) { name.strip }
  normalizes :email, with: -> (email) { email.strip.downcase }

  
end
