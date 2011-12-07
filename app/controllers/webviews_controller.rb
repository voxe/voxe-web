class WebviewsController < ApplicationController
  
  layout false
  
  def index
  end
  
  def compare
    @election   = Election.find params[:electionId]
    @candidates = Candidate.find params[:candidateIds].split(',')
    @theme      = Theme.find params[:themeId]
    
    @propositions = Proposition.where electionId: @election.id,
      :candidateId.in => @candidates.collect(&:id),
      # :themeId.in => sections_ids
      :themeId.in => @theme.sections.collect(&:id)
  end
  
  def propositions
    @proposition = Proposition.find params[:id]
  end
  
end