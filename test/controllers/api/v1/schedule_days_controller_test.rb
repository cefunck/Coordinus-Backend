require "test_helper"

class Api::V1::ScheduleDaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_schedule_days_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_schedule_days_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_schedule_days_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_schedule_days_destroy_url
    assert_response :success
  end
end
