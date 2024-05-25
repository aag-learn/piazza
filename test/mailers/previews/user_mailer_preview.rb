class UserMailerPreview < ActionMailer::Preview
  def password_reset
    user = User.first
    UserMailer.with(user:).password_reset
  end
end
