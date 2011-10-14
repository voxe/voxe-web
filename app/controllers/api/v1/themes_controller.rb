class Api::V1::ThemesController < ApplicationController

  # POST /api/v1/themes
  def create
    @theme = Theme.new params[:theme]

    if @theme.save
      render json: {theme: @theme}
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/themes
  def index
    @themes = Theme.all

    render json: {themes: @themes}
  end

  # POST /api/v1/themes/1/addphoto
  def addphoto
    @theme = Theme.find params[:id]
    photo  = @theme.photos.build type: params[:type], image: params[:image]

    if photo.save
      render json: {photo: photo}
    else
      render json: photo.errors, status: :unprocessable_entity
    end
  end

end
