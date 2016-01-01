class EndpointsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_endpoint, only: [:edit, :update]

  def index
    @endpoints = Endpoint.non_zombie
  end

  def new
    @endpoint = Endpoint.new
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    if @endpoint.save
      flash[:notice] = 'Endpoint successfully created'
      redirect_to endpoints_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @endpoint.update(endpoint_params)
      flash[:notice] = 'Endpoint successfully updated'
      redirect_to endpoints_path
    else
      render :edit
    end
  end

  private

  def set_endpoint
    @endpoint = Endpoint.find(params[:id])
  end

  def endpoint_params
    params.require(:endpoint).permit(:name)
  end
end
