class RegistrationsController < Devise::RegistrationsController
  include NoAuthenticity  
  respond_to :json
end
