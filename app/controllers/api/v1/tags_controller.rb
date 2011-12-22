class Api::V1::TagsController < Api::V1::ApplicationController

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