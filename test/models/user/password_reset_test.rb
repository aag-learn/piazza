require 'test_helper'

class User
  class PasswordResetTest < ActiveSupport::TestCase
    include ActionMailer::TestHelper

    setup do
      @user = users(:jerry)
      ActionMailer::Base.deliveries.clear
    end

    test "resetting a user's password destroys all sessions and sends an email" do
      @user.app_sessions.create
      @user.app_sessions.create

      @user.reset_password
      assert_emails 1
      assert_empty @user.reload.app_sessions
    end

    test 'can retrieve a user with a valid password_reset token' do
      token = @user.generate_token_for(:password_reset)
      assert_equal @user, User.find_by_token_for(:password_reset, token)
    end

    test 'retrieve a user with an expired password_reset token returns nil' do
      token = @user.generate_token_for(:password_reset)
      travel 3.hours
      assert_nil User.find_by_token_for(:password_reset, token)
    end

    test 'retreiving a user with an outdated password_reset token returns nil' do
      token = @user.generate_token_for(:password_reset)
      @user.update(password: 'new_password')
      assert_nil User.find_by_token_for(:password_reset, token)
    end
  end
end
