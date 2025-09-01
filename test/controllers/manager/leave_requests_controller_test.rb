require "test_helper"

class Manager::LeaveRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_leave_requests_index_url
    assert_response :success
  end

  test "should get update" do
    get manager_leave_requests_update_url
    assert_response :success
  end
end
