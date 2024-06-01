require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  setup do
    @user = users(:jerry)
    ActionMailer::Base.deliveries.clear
  end

  test 'password reset' do
    email = UserMailer
            .with(user: @user)
            .password_reset('reset_token')
            .deliver_now

    assert_match @user.name, email[:to].unparsed_value
    assert_match @user.email, email[:to].unparsed_value

    assert_select_email do
      url = edit_users_password_reset_url('reset_token')
      assert_select 'a.button[href="' + url + '"]'
    end
  end
end
