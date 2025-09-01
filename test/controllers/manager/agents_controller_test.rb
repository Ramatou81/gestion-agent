require "test_helper"

class Manager::AgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manager_agents_index_url
    assert_response :success
  end

  test "should get show" do
    get manager_agents_show_url
    assert_response :success
  end
end
