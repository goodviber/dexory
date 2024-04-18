require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get inventories_upload_url
    assert_response :success
  end
end
