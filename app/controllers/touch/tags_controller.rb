class Touch::TagsController < Touch::ApplicationController
  
  before_filter :set_election
  
  def index
    @options = {electionId: @election.id}
    render "touch/elections/index"
  end
  
end