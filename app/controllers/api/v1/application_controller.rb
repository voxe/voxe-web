class Api::V1::ApplicationController < ApplicationController

  layout "api_v1.json"

  # Handle errors
  rescue_from BSON::InvalidObjectId, with: :api_error_400
  rescue_from Mongoid::Errors::DocumentNotFound, with: :api_error_400

  # Authorization with CanCan
  load_and_authorize_resource

  # Skip authenticity token is more easy for an API
  skip_before_filter :verify_authenticity_token
  
  # Skip touch version
  skip_before_filter :set_touch_format

  private

  def api_error_400 exception
    @api_errors = {
      errorType: "param_error",
      errorDetail: exception.to_s
    }
    render layout: "api_v1", status: 400
  end

end
