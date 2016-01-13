class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [
    	:name, :last_name, :country
    ]

    devise_parameter_sanitizer.for(:account_update) << [
      :name, :last_name, :country
    ]
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
    # return home_page_path for user using current_user method
  end
end
