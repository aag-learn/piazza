class AppSession < ApplicationRecord
  has_secure_password :token, validations: false

  belongs_to :user

  before_create do 
    self.token = self.class.generate_unique_secure_token
  end

  def to_h 
    { 
      user_id: user.id,
      app_session_id: id,
      token: self.token,
    }
  end
end
