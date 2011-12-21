class Api::V1::TagsController < ApplicationController
  
  load_and_authorize_resource
  skip_before_filter :verify_authenticity_token

  # POST /api/v1/tags
  def create
    if @tag.save
      render 'api/v1/tags/show.rabl'
    else
      render json: {errors: @tag.errors}, status: :unprocessable_entity
    end
  end
  
  # GET /api/v1/tags/{id}
  def show
  end

end