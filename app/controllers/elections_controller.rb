class ElectionsController < ApplicationController
  
  def index 
    @elections = Election.all
  end
  
  def show
    @election = Election.first conditions: {namespace: params[:election]}
    # returns 404 if election does not exist
    return not_found unless @election
    
    respond_to do |format|
      format.html
      format.touch do
        @json = render_to_string('api/v1/elections/show', layout: false)
      end
    end
  end
  
  def themes
    @election   = Election.first conditions: {namespace: params[:election]}
    # returns 404 if election does not exist
    return not_found unless @election
    @candidates = Candidate.where(:namespace.in => params[:candidates].split(',')).all
    # returns 404 if candidates is empty
    return not_found if @candidates.blank?
  end
  
  def compare
    @election   = Election.first conditions: {namespace: params[:election]}
    # returns 404 if election does not exist
    return not_found unless @election
    @candidates = Candidate.where(:namespace.in => params[:candidates].split(',')).all
    # returns 404 if candidates is empty
    return not_found if @candidates.blank?
    @themes     = [Theme.first]
    # returns 404 if theme is not valid
    return not_found if @candidates.blank?
    
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