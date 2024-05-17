require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'new user can sig in' do
    visit root_path
    click_on I18n.t('application.navbar.sign_up')
    fill_in User.human_attribute_name(:name), with: 'Newman'
    fill_in User.human_attribute_name(:email), with: 'newman@example.com'
    fill_in User.human_attribute_name(:password), with: 'short'
    fill_in User.human_attribute_name(:password_confirmation), with: 'short'

    click_on I18n.t('users.new.sign_up')
    assert_selector 'p.is-danger', text: I18n.t('activerecord.errors.models.user.attributes.password.too_short')

    fill_in User.human_attribute_name(:password), with: 'password'
    fill_in User.human_attribute_name(:password_confirmation), with: 'password'

    click_on I18n.t('users.new.sign_up')

    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('users.create.welcome', name: 'Newman')
    assert_selector '.navbar-dropdown', visible: false
  end

  test 'existing user can log in' do
    visit root_path
    click_on I18n.t('application.navbar.login')

    fill_in User.human_attribute_name(:email), with: 'jerry@example.com'
    fill_in User.human_attribute_name(:password), with: 'wrong'
    click_button I18n.t('sessions.new.submit')
    assert_selector '.notification.is-danger', text: I18n.t('sessions.create.incorrect_details')

    fill_in User.human_attribute_name(:email), with: 'jerry@example.com'
    fill_in User.human_attribute_name(:password), with: 'password'
    click_button I18n.t('sessions.new.submit')

    assert_current_path root_path

    assert_selector '.notification', text: I18n.t('sessions.create.success')
    assert_selector '.navbar-dropdown', visible: false
  end

  test 'can update name' do
    user = users(:jerry)
    log_in(user)

    visit profile_path

    fill_in User.human_attribute_name(:name), with: 'The new Jerry'
    click_button I18n.t('users.show.save_profile')
    assert_selector 'form .notification', text: I18n.t('users.update.success')
    assert_selector '#current_user_name', text: user.name
  end

  test 'can log out in the desktop' do
    user = users(:jerry)
    log_in(user)

    visit root_path

    find('.navbar-item.is-hoverable').hover
    click_on I18n.t('application.navbar.logout')

    assert_current_path root_path
    assert_selector '.notification', text: I18n.t('sessions.destroy.success')
  end
end
