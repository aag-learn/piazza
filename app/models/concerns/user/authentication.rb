class User
  module Authentication
    extend ActiveSupport::Concern

    included do
      has_secure_password
      validates :password, presence: true, length: { minimum: 8 }, on: %i[create password_change]

      has_many :app_sessions
      def self.create_app_session(email:, password:)
        user = User.authenticate_by(email:, password:)
        user.app_sessions.create if user.present?
      end

      def authenticate_app_session(app_session_id, token)
        app_sessions.find(app_session_id).authenticate_token(token)
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  end
end
