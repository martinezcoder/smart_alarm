module NoAuthenticity
  extend ActiveSupport::Concern
  included do
    skip_before_action :verify_authenticity_token, if: :json_request?
  end
  
  private

  def json_request?
    request.format.json?
  end
end
