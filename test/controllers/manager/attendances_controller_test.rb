require "test_helper"

class Manager::AttendancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_attendances_index_url
    assert_response :success
  end
end
