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
end
