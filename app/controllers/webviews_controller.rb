class WebviewsController < ApplicationController
  
  layout false
  
  def index
  end
  
  def compare
    @election   = Election.find params[:electionId]
    @candidates = Candidate.find params[:candidateIds].split(',')
    @theme      = Theme.find params[:themeId]
  end
  
  def propositions
    @proposition = Proposition.find params[:id]
  end
  
end