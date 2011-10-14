class Api::V1::CandidatesController < ApplicationController

  # POST /api/v1/candidates
  def create
    @candidate = Candidate.new params[:candidate]

    if @candidate.save
      render json: {candidate: @candidate}
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/candidates/1
  def show
    @candidate = Candidate.find params[:id]

    render json: {candidate: @candidate}
  end

  # GET /api/v1/candidates/1/elections
  def elections
    @candidate = Candidate.find params[:id]
    @elections = @candidate.elections

    render json: {elections: @elections}
  end

  # POST /api/v1/candidates/1/addphoto
  def addphoto
    @candidate = Candidate.find params[:id]
    photo      = @candidate.photos.build type: params[:type], image: params[:image]

    if photo.save
      render json: {photo: photo}
    else
      render json: photo.errors, status: :unprocessable_entity
    end
  end

end
