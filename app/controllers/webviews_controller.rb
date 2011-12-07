class WebviewsController < ApplicationController
  
  layout false
  
  def index
  end
  
  def compare
    # election
    begin
      @election = Election.find params[:electionId]
    rescue
      return render text: "invalid electionId"
    end
    
    # candidates
    begin
      @candidates = Candidate.find params[:candidateIds].split(',')
    rescue
      return render text: "invalid candidateIds"
    end
    
    # theme
    begin
      @theme = Theme.find params[:themeId]
    rescue
      return render text: "invalid themeId"
    end
    
    @propositions = Proposition.where electionId: @election.id,
      :candidateId.in => @candidates.collect(&:id),
      # :themeId.in => sections_ids
      :themeId.in => @theme.sections.collect(&:id)
  end
  
  def propositions
    @proposition = Proposition.find params[:id]
  end
  
end