class AppSession < ApplicationRecord
  has_secure_password :token, validations: false

  belongs_to :user

  before_create do 
    self.token = self.class.generate_unique_secure_token
  end
end
