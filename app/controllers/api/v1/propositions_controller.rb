class Api::V1::PropositionsController < ApplicationController
  load_and_authorize_resource

  # GET /api/v1/propositions/search
  def search
    @election   = Election.find params[:electionId]
    @candidates = Candidate.find params[:candidateIds].split(',')
    @tag        = Tag.find params[:themeId]

    @propositions = Proposition.where electionId: @election.id,
      :candidateId.in => @candidates.collect(&:id),
      :tags_ids.in => @tag.id
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
