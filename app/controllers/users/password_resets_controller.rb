class Users::PasswordResetsController < ApplicationController
  before_action :load_user, only: %i[edit update]
  skip_authentication

  def new; end

  def create
    User.find_by(email: params[:email])&.reset_password
  end

  def edit; end

  def update
    @user.assign_attributes(password_reset_params)
    if @user.save(context: :password_change)
      @app_session = @user.app_sessions.create
      log_in(@app_session)
      flash[:success] = t('.success')
      recede_or_redirect_to root_path, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password)
  end

  def load_user
    @user = User.find_by_token_for(:password_reset, params[:id])
    return unless @user.blank?

    redirect_to new_users_password_reset_path, status: :see_other,
                                               flash: { error: t('users.password_resets.invalid_link') }
  end
end
