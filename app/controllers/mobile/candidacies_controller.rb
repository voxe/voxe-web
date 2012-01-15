class Mobile::CandidaciesController < Mobile::ApplicationController
  
  before_filter :set_election
  
  def create
    @candidacies = Candidacy.find params[:candidacies]
    
    redirect_to tags_path @election.namespace, @candidacies.collect { |c| c.namespace }.join(',')
  end
  
end