require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  # https://gorails.com/blog/how-to-test-helpers-in-rails-with-devise-current_user-and-actionview-testcase
  def turbo_native_app?
    @turbo_native_app
  end

  setup do
    @turbo_native_app = false
  end

  test 'formats page specific title' do
    content_for(:title) { 'The title' }

    assert_equal "The title | #{I18n.t('piazza')}", title
  end

  test 'returns app name when page title is missing' do
    assert_equal I18n.t('piazza'), title
  end

  test 'only page specific title is returned for turbo native' do
    @turbo_native_app = true

    content_for(:title) { 'The Turbo Native title' }

    assert_equal 'The Turbo Native title', title
  end
end
