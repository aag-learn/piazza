require 'application_system_test_case'

module Mobile
  class UsersTest < MobileSystemTestCase
    test 'can log out in mobile devices' do
      user = users(:jerry)
      log_in(user)

      visit profile_path

      log_out
    end
  end
end
