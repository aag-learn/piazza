require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'new user can sig in' do
    visit root_path
    click_on I18n.t('application.navbar.sign_up')
  end
end
