class Api::V1::ScheduleDaysController < ApplicationController
  def index
    schedule_days = ScheduleDay.all
    render json: schedule_days
  end

  def create
    # TODO: implementar
  end

  def update
    # TODO: implementar
  end

  def destroy
    # TODO: implementar
  end
end
