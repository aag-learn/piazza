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

  def log_out
    find('.navbar-item.is-hoverable').hover
    click_on I18n.t('application.navbar.logout')

    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('sessions.destroy.success')
  end

  def extract_primary_link_from_email
    email = ActionMailer::Base.deliveries.last
    html_body = Nokogiri::HTML(email.html_part.body.decoded)

    primary_link = html_body.css('a.button').attr('href').value
    primary_link = URI(primary_link)
    "#{primary_link.path}?#{primary_link.query}"
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

  def log_out
    find('.navbar-burger').click
    click_link I18n.t('application.navbar.logout')
    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('sessions.destroy.success')
  end
end
