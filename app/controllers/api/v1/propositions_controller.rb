class Api::V1::PropositionsController < ApplicationController

  # GET /api/v1/propositions/search
  def search
    election   = Election.find(params[:electionId])
    candidates = Candidate.find(params[:candidateIds].split(','))
    themes     = Theme.find(params[:themeIds].split(','))

    @propositions = Proposition.where election_id: election.id,
      candidate_id: candidates.collect(&:id),
      theme_id: themes.collect(&:id)

    render json: { propositions: @propositions }
  end

end
