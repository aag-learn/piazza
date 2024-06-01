require 'test_helper'

class Users::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)

    ActionMailer::Base.deliveries.clear
  end
  test 'creating a password reset sends an email and and shows instructions' do
    post users_password_resets_path, params: { email: @user.email }
    assert_response :ok
    assert_select 'p', text: I18n.t('users.password_resets.create.message')
    assert_emails 1
  end

  test 'accessing the password reset page with a valid token displays the form' do
    token = @user.generate_token_for(:password_reset)
    get edit_users_password_reset_path(token)
    assert_response :ok
    assert_select 'form[action="' + users_password_reset_path(token) + '"][method="post"]'
  end

  test 'accessing the password reset page with an invalid token or nil redirects' do
    get edit_users_password_reset_path('invalid')
    assert_redirected_to new_users_password_reset_path

    get edit_users_password_reset_path
    assert_redirected_to new_users_password_reset_path
  end

  test 'resetting a password logs in and sets the new password' do
    token = @user.generate_token_for(:password_reset)
    patch users_password_reset_path(token, params: { user: { password: 'TheNewPassword' } })
    assert_redirected_to root_path
    follow_redirect!
    assert_response :ok
    @user.authenticate('TheNewPassword')
  end

  test 'entering a password that is too short renders an error' do
    token = @user.generate_token_for(:password_reset)
    patch users_password_reset_path(token, params: { user: { password: 'short' } })

    assert_response :unprocessable_entity
    assert_select '.is-danger',
                  text: I18n.t('activerecord.errors.models.user.attributes.password.too_short', count: 8)
  end
end
