class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user_from_token!, if: :api_endpoint?
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

  private

  def api_endpoint?
    # Use this method to allow only specific controllers/actions to be accessed via the API
    controller_name == 'endpoints' && action_name ==  'index'
  end

  def authenticate_user_from_token!
    user_token = request.headers["X-User-Token"].presence
    user_email = request.headers["X-User-Email"].presence
    user = user_token && user_email &&
      User.where(authentication_token: user_token.to_s, email: user_email).first
    if user
      sign_in user, store: false
    end
  end
end
