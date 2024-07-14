require 'test_helper'

class PaginationHelperTest < ActionView::TestCase
  setup do
    @turbo_native_app = false
    @pagy = Struct.new(:pages).new(1)
  end

  test "don't show pagination in native apps" do
    @turbo_native_app = true
    assert_not show_paginator?

    @pagy.pages = 2
    assert_not show_paginator?
  end

  test "don't show pagination if there's just one page" do
    assert_not show_paginator?
  end

  test "show pagination if there's more thatn one page" do
    @pagy.pages = 2
    assert show_paginator?
  end

  private

  def turbo_native_app?
    @turbo_native_app
  end
end
