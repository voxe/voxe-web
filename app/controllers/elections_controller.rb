class ElectionsController < ApplicationController
  
  def index 
    @elections = Election.all
  end
  
  def show
    @election = Election.find params[:id]
  end
  
  def compare
    @election   = Election.find params[:id]
    @candidates = Candidate.find params[:candidates]
    @themes     = Theme.find params[:themes]
    
    @propositions = {}
    @candidates.each do |candidate|
      @propositions[candidate.id] = {}
      @themes.each do |theme|
        theme.themes.each do |category|
          category.themes.each do |section|
            @propositions[candidate.id][section.id] = Proposition.where :candidateId => candidate.id, :electionId => @election.id, :themeId => section.id
          end
        end
      end
    end
  end
  
end