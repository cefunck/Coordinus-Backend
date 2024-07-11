class Api::V1::ShiftsController < ApplicationController
  def index
    shifts = Shift.all
    render json: shifts
  end

  def create
    @shift = Shift.new(shift_params)

    if @shift.save
      render json: @shift, status: :created
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def update
    @shift = Shift.find(params[:id])

    if @shift.update(shift_params)
      render json: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # TODO: implementar
  end

  private

  def shift_params
    params.require(:shift).permit(:user_time_zone, :start_time, :end_time, client_service_id, assigned_user_id, available_users_ids)
  end
end
