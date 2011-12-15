class Api::V1::TagsController < ApplicationController
  load_and_authorize_resource

  # POST /api/v1/tags
  def create
    if @tag.save
      render json: {theme: @tag}
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

end
