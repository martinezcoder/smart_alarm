class SessionsController < Devise::SessionsController
  include NoAuthenticity
  respond_to :json
end
