class Plugins::CompareController < ApplicationController
  
  layout false
  
  def index
    @election = Election.find params[:id]
  end
  
  def propositions
    @election   = Election.find params[:electionId]
    @candidates = Candidate.find params[:candidateIds].split(',')
    @theme      = Theme.find params[:themeId]
    
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
  
end