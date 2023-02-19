require "test_helper"

class PhotoCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get photo_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get photo_comments_edit_url
    assert_response :success
  end
end
