class Api::V1::ScheduleTimeRangesController < ApplicationController
  def index
    schedule_time_ranges = ScheduleTimeRange.all
    render json: schedule_time_ranges
  end

  def create
  end

  def update
  end

  def destroy
  end
end
