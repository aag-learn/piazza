require 'application_system_test_case'

module Mobile
  class UsersTest < MobileSystemTestCase
    test 'can log out in mobile devices' do
      user = users(:jerry)
      log_in(user)

      visit root_path

      find('.navbar-burger').click
      click_link I18n.t('application.navbar.logout')

      assert_current_path root_path
      assert_selector '.notification', text: I18n.t('sessions.destroy.success')
    end
  end
end
