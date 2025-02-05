require "test_helper"

class Api::V1::ScheduleTimeRangesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_schedule_time_ranges_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_schedule_time_ranges_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_schedule_time_ranges_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_schedule_time_ranges_destroy_url
    assert_response :success
  end
end
