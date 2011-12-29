class Api::V1::CandidaciesController < Api::V1::ApplicationController
  # GET /api/v1/candidacies/1
  def show
  end

  # PUT /api/v1/candidacies/1
  def update
    if @candidacy.update_attributes params[:candidacy]
      render 'api/v1/candidacies/show.rabl', status: :ok
    else
      render json: {errors: @candidacy.errors}, status: :unprocessable_entity
    end
  end
end
