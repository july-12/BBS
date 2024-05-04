require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get slug" do
    get categories_slug_url
    assert_response :success
  end
end
