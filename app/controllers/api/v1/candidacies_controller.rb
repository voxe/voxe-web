class Api::V1::CandidaciesController < ApplicationController
  layout "api_v1"
  load_and_authorize_resource

  # GET /api/v1/candidacies/1
  def show
  end
end
