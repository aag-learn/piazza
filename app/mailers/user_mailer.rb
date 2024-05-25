class UserMailer < ApplicationMailer
  before_action :set_user

  default to: -> { "\"#{@user.name}\" <#{@user.email}>" }
  def password_reset
    mail subject: t('.subject')
  end

  private

  def set_user
    @user = params[:user]
  end
end
