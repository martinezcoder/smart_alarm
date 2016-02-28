class ContactsController < ApplicationController
  before_action :set_contact, only: [:edit, :update, :show]

  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def show
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      flash[:notice] = 'contact successfully created'
      redirect_to contacts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      flash[:notice] = 'Contact successfully updated'
      redirect_to contacts_path
    else
      render :edit
    end
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:email, :name, :phone_number)
  end
end
