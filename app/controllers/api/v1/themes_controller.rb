class Api::V1::ThemesController < ApplicationController

  # POST /api/v1/themes
  def create
    @theme = Theme.new(params[:theme])

    if @theme.save
      head :ok
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

end
