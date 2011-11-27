class Api::V1::PropositionsController < ApplicationController
  
  load_and_authorize_resource

  # GET /api/v1/propositions/search
  def search
    @election   = Election.find params[:electionId]
    @candidates = Candidate.find params[:candidateIds].split(',')
    @theme      = Theme.find params[:themeId]
    
    
    sections_ids = []
    @theme.themes.each do |category|
      category.themes.each do |section|
        sections_ids << section.id
      end
    end
    
    @propositions = Proposition.where electionId: @election.id,
      :candidateId.in => @candidates.collect(&:id),
      :themeId.in => sections_ids
  end

  # POST /api/v1/propositions
  def create
    if @proposition.save
      render json: {proposition: @proposition}
    else
      render json: @proposition.errors, status: :unprocessable_entity
    end
  end

end
