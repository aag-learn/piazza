# frozen_string_literal: true

class User < ApplicationRecord
  include User::Authentication
  include User::PasswordReset
  include User::PermittedAttributes

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :listings, inverse_of: :creator

  normalizes :name, with: ->(name) { name.strip }
  normalizes :email, with: ->(email) { email.strip.downcase }
end
