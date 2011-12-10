class WebviewsController < ApplicationController
  
  # touch
  before_filter :set_format
  
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
    
    @propositions = {}
    @candidates.each do |candidate|
      @propositions[candidate.id] = {}
      @theme.themes.each do |category|
        category.themes.each do |section|
          @propositions[candidate.id][section.id] = Proposition.where :candidateId => candidate.id, :electionId => @election.id, :themeId => section.id
        end
      end
    end
  end
  
  def proposition
    @proposition = Proposition.find params[:propositionId]
  end
  
  private
    def set_format
      request.format = :touch
    end
  
end