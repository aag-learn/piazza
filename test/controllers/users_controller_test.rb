require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'redirects to feed after successful sign up' do
    get sign_up_path
    assert_response :ok

    assert_difference ['User.count', 'Organization.count'], 1 do
      post sign_up_path, params: {
        user: {
          name: 'The name',
          password: '12345678',
          password_confirmation: '12345678',
          email: 'test@email.com'
        }
      }
    end

    assert_redirected_to root_path
    assert_not_empty cookies[:app_session]
    follow_redirect!

    assert_select '.notification.is-success', text: I18n.t('users.create.welcome', name: 'The name')
  end

  test 'render errors if input data is invalid' do
    get sign_up_path
    assert_response :ok

    assert_no_difference ['User.count', 'Organization.count'] do
      post sign_up_path, params: {
        user: {
          name: 'The name',
          password: '1234',
          password_confirmation: '1234',
          email: 'test_email.com'
        }
      }
    end

    assert_response :unprocessable_entity

    assert_select 'p.is-danger', text: I18n.t('activerecord.errors.models.user.attributes.password.too_short')
  end

  test 'render errors if passwords don not match' do
    get sign_up_path
    assert_response :ok

    assert_no_difference ['User.count', 'Organization.count'] do
      post sign_up_path, params: {
        user: {
          name: 'The name',
          password: '12345678',
          password_confirmation: '12345',
          email: 'test@email.com'
        }
      }
    end

    assert_response :unprocessable_entity

    assert_select 'p.is-danger',
                  text: I18n.t('activerecord.errors.models.user.attributes.password_confirmation.confirmation')
  end

  test 'can update user profile' do
    @user = users(:jerry)
    log_in @user

    patch profile_path params: {
      user: {
        name: 'Jerry the ant'
      }
    }

    assert_redirected_to profile_path
    assert_equal 'Jerry the ant', @user.reload.name
  end

  test 'can show the profile' do
    @user = users(:jerry)
    log_in @user

    get profile_path
    assert_select 'input#user_name', value: @user.name
    assert_select 'input#user_email', value: @user.email
  end
end
