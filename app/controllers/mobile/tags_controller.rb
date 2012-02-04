class Mobile::TagsController < Mobile::ApplicationController
  
  before_filter :set_election
  
  def index
    if params[:candidacies].blank?
      redirect_to @election
    end
    
    # title
    candidacies = @election.candidacies.select do |candidacy|
      params[:candidacies].split(',').include? candidacy.namespace
    end
    @page_title = candidacies.collect { |candidacy| candidacy.name }.join(', ')
    @page_title += " | #{@election.name}"
  end
  
end
