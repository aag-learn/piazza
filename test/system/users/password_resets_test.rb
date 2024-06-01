require 'application_system_test_case'

module Users
  class PasswordResetsTest < ApplicationSystemTestCase
    setup do
      @user = users(:jerry)
      ActionMailer::Base.deliveries.clear
    end

    test 'can reset password and log in' do
      visit login_path
      click_on I18n.t('sessions.new.password_reset')

      fill_in I18n.t('users.password_resets.new.email_label'), with: @user.email
      click_on I18n.t('users.password_resets.new.submit')
      assert_text I18n.t('users.password_resets.create.message')

      password_reset_url = extract_primary_link_from_email
      visit password_reset_url
      fill_in User.human_attribute_name(:password), with: 'pw'
      click_on I18n.t('users.password_resets.edit.submit')
      assert_selector '.is-danger',
                      text: I18n.t('activerecord.errors.models.user.attributes.password.too_short', count: 8)

      fill_in User.human_attribute_name(:password), with: 'TheNewPassword'
      click_on I18n.t('users.password_resets.edit.submit')
      assert_current_path root_path
    end
  end
end
