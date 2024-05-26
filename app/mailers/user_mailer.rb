class UserMailer < ApplicationMailer
  before_action :set_user

  default to: -> { "\"#{@user.name}\" <#{@user.email}>" }
  def password_reset(token)
    @password_reset_token = token
    mail subject: t('.subject')
  end

  private

  def set_user
    @user = params[:user]
  end
end
