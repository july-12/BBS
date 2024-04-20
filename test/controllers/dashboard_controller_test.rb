require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end

  test "should get comment" do
    get dashboard_comment_url
    assert_response :success
  end

  test "should get favorite" do
    get dashboard_favorite_url
    assert_response :success
  end
end
