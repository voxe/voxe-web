class Api::V1::ElectionsController < ApplicationController
  
  load_and_authorize_resource

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
      render json: { election: @election }, status: :created
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/elections/1/addtheme
  def addtheme
    @theme = Theme.find params[:themeId]

    @election.themes << @theme

    if @election.save
      render json: {theme: @theme}
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/elections/1/addcandidate
  def addcandidate
    @candidate = Candidate.find params[:candidateId]

    @election.candidates << @candidate

    if @election.save
      render json: {candidate: @candidate}
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

end
