require 'test_helper'

class User::AuthenticationTest < ActiveSupport::TestCase
  test "password length must be between 8 and ActiveRecord's maximum" do
    @user = User.new(name: 'The name', email: 'test@email.com', password: '')

    assert_not @user.valid?

    @user.password = 'password'
    assert @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = 'a' * (max_length + 1)
    assert_not @user.valid?
  end

  test 'can create a session with email and correct password' do
    app_session = User.create_app_session(email: 'jerry@example.com', password: 'password')

    assert_not_nil app_session
    assert_not_nil app_session.token
  end

  test 'cannot create a session with email and incorrect password' do
    app_session = User.create_app_session(email: 'jerry@example.com', password: 'WRONG')

    assert_nil app_session
  end

  test 'cannot create a session with non existing email' do
    app_session = User.create_app_session(email: 'does_not_exist@example.com', password: 'password')

    assert_nil app_session
  end

  test 'can authenticate with a valid session id and token' do
    user = users(:jerry)
    app_session = user.app_sessions.create

    assert_equal app_session, user.authenticate_app_session(app_session.id, app_session.token)
  end

  test 'trying to authenticate with a token that does not exist returns false' do
    user = users(:jerry)
    app_session = user.app_sessions.create
    assert_not user.authenticate_app_session(app_session.id, 'token')
  end
end
