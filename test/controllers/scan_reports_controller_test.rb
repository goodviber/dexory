require "test_helper"

class ScanReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get scan_reports_upload_url
    assert_response :success
  end

  test "should get compare" do
    get scan_reports_compare_url
    assert_response :success
  end
end
