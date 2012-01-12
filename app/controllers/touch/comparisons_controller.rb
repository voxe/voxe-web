class Touch::ComparisonsController< Touch::ApplicationController
  
  before_filter :set_election
 
  def show
    @options = {electionId: @election.id}
    render "touch/elections/index"
  end
  
end