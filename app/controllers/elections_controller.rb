class ElectionsController < ApplicationController
  
  def index 
    @elections = Election.all
  end
  
  def show
    @election = Election.first conditions: {namespace: params[:election]}
  end
  
  def themes
    @election   = Election.first conditions: {namespace: params[:election]}
    @candidates = Candidate.where(:namespace.in => params[:candidates].split(',')).all
  end
  
  def compare
    @election   = Election.first conditions: {namespace: params[:election]}
    @candidates = Candidate.where(:namespace.in => params[:candidates].split(',')).all
    @themes     = [Theme.first]
    
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