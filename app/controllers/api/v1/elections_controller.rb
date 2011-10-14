class Api::V1::ElectionsController < ApplicationController

  # GET /api/v1/elections/1
  def show
    @election = Election.find params[:id]

    render json: { election: @election.as_json(
      only:    [:id, :name],
      # FIXME
      include: {candidates: {only: [:id, :firstName, :lastName, :photos]}},
      methods: [:themes]
    ) }
  end

  # GET /api/v1/elections/search
  def search
    @elections = Election.all

    render json: { elections: @elections.as_json(only: [:id, :name]) }
  end

  # POST /api/v1/elections
  def create
    @election = Election.new params[:election]

    if @election.save
      render json: { election: @election.as_json(only: [:id, :name]) }, status: :created
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/elections/1/addtheme
  def addtheme
    @election     = Election.find params[:id]
    @theme        = Theme.find params[:themeId]
    @parent_theme = Theme.find(params[:parentThemeId]) if params[:parentThemeId]

    unless @parent_theme
      @election.theme_ids[@theme.to_param] ||= []
    else
      @election.theme_ids[@parent_theme.to_param] ||= []
      @election.theme_ids[@parent_theme.to_param] << @theme.to_param
    end

    if @election.save
      render json: {theme: @theme}
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # POST /api/v1/elections/1/addcandidate
  def addcandidate
    @election  = Election.find params[:id]
    @candidate = Candidate.find params[:candidateId]

    @election.candidate_ids << @candidate.to_param

    if @election.save
      render json: {candidate: @candidate}
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

end
