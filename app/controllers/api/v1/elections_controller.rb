class Api::V1::ElectionsController < ApplicationController
  
  layout "api_v1"
  
  load_and_authorize_resource
  skip_before_filter :verify_authenticity_token

  # GET /api/v1/elections/1
  def show
  end

  # GET /api/v1/elections/search
  def search
    @elections = Election.all
  end

  # POST /api/v1/elections
  def create
    if @election.save
      render 'api/v1/elections/show.rabl', status: :created
    else
      render json: {errors: @election.errors}, status: :unprocessable_entity
    end
  end

  # POST /api/v1/elections/1/addcandidate
  def addcandidate
    @candidate = Candidate.find params[:candidateId]

    @election.candidates << @candidate

    if @election.save
      render json: 'api/v1/candidates/show.rabl'
    else
      render json: {errors: @election.errors}, status: :unprocessable_entity
    end
  end

end
