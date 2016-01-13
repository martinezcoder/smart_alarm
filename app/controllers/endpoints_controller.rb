class EndpointsController < ApplicationController
  before_action :authenticate_user!, except: [:execute]
  before_action :set_endpoint, only: [:edit, :update, :show]
  skip_before_action :verify_authenticity_token, only: [:execute]

  def index
    @endpoints = current_user.endpoints.non_zombie
  end

  def new
    @endpoint = Endpoint.new
  end

  def show
  end

  def create
    @endpoint = current_user.endpoints.new(endpoint_params)
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
    new_attrs = endpoint_params
    new_attrs[:interval] ||= nil
    if @endpoint.update(new_attrs)
      flash[:notice] = 'Endpoint successfully updated'
      redirect_to endpoints_path
    else
      render :edit
    end
  end

  def execute
    AlertWorker.perform_async(params[:uuid])
    head :ok
  end

  private

  def set_endpoint
    @endpoint = current_user.endpoints.find(params[:id])
  end

  def endpoint_params
    params.require(:endpoint).permit(:name, :interval, :recipients)
  end
end
