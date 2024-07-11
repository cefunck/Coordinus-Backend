class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
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
