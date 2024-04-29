require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "formats page specific title" do 
    content_for(:title) { "The title" }

    assert_equal "The title | #{I18n.t("piazza")}", title
  end

  test "returns app name when page title is missing" do 
    assert_equal I18n.t("piazza"), title
  end

end
