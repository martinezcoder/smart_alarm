class EndpointsController < ApplicationController
  before_action :set_endpoint, only: [:edit, :update, :show]
  before_action :set_contacts, only: [:index, :edit]

  skip_before_action :authenticate_user!, only: [:execute]

  def index
    @endpoints = current_user.endpoints
    @endpoint = Endpoint.new
  end

  def show
  end

  def create
    @endpoint = current_user.endpoints.new(endpoint_params)
    if @endpoint.save
      flash[:notice] = 'Endpoint successfully created'
      render js: "window.location.href = ('#{endpoints_path}');"
    else
      render status: 400, json: { errors: @endpoint.errors.full_messages }
    end
  end

  def edit
  end

  def update
    new_attrs = endpoint_params
    new_attrs[:interval] ||= nil
    if @endpoint.update(new_attrs)
      flash[:notice] = 'Endpoint successfully updated'
      respond_to do |format|
        format.html { redirect_to endpoints_path }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render status: 400, json: { errors: @endpoint.errors.full_messages } }
      end
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

  def set_contacts
    @contacts = current_user.contacts
  end

  def endpoint_params
    params.require(:endpoint).permit(
      :name,
      :interval,
      :recipients,
      :status,
      :contacts_endpoints_attributes => [
        :contact_id,
        :kind
      ]
    )
  end
end
