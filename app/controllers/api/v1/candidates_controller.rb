class Api::V1::CandidatesController < Api::V1::ApplicationController

  # POST /api/v1/candidates
  def create
    if @candidate.save
      render 'api/v1/candidates/show.rabl', status: :created
    else
      render json: {errors: @candidate.errors}, status: :unprocessable_entity
    end
  end

  # GET /api/v1/candidates/1
  def show
  end

  # POST /api/v1/candidates/1/addphoto
  def addphoto
    photo = @candidate.photos.build type: params[:type], image: params[:image]

    if photo.save
      render json: {photo: photo}
    else
      render json: {errors: photo.errors}, status: :unprocessable_entity
    end
  end

end
