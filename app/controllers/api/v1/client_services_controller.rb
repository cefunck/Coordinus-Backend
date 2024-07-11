class Api::V1::ClientServicesController < ApplicationController
  def index
    client_services = ClientService.all
    render json: client_services
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
