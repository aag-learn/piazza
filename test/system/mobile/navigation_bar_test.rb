require 'application_system_test_case'

module Mobile
  class NavigationBarTest < MobileSystemTestCase
    test 'can access sign up page via the burger menu' do
      find('.navbar-burger').click
      click_on I18n.t('application.navbar.sign_up')

      assert_current_path sign_up_path
    end

    test 'can access login up page via the burger menu' do
      find('.navbar-burger').click
      click_on I18n.t('application.navbar.login')

      assert_current_path login_path
    end
  end
end
