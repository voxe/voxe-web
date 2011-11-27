class Api::V1::ThemesController < ApplicationController
  
  load_and_authorize_resource

  # POST /api/v1/themes
  def create
    if @theme.save
      render json: {theme: @theme}
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/themes/1/addphoto
  def addphoto
    photo = @theme.photos.build type: params[:type], image: params[:image]

    if photo.save
      render json: {photo: photo}
    else
      render json: photo.errors, status: :unprocessable_entity
    end
  end

end
