require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DESKTOP_SIZE = [1400, 1400].freeze
  MOBILE_SIZE = [375, 812].freeze

  driven_by :selenium, using: :chrome, screen_size: DESKTOP_SIZE

  private

  def log_in(user, password: 'password')
    visit login_path

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: password
    click_button I18n.t('sessions.new.submit')
    assert_current_path root_path
  end
end

class MobileSystemTestCase < ApplicationSystemTestCase
  setup do
    visit root_path
    current_window.resize_to(*MOBILE_SIZE)
  end

  teardown do
    current_window.resize_to(*DESKTOP_SIZE)
  end
end
