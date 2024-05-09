require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DESKTOP_SIZE = [1400, 1400].freeze
  MOBILE_SIZE = [375, 812].freeze

  driven_by :selenium, using: :chrome, screen_size: DESKTOP_SIZE
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
