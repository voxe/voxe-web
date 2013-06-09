class NewAdmin::CandidaciesController < AdminController
  def index
    @election = Election.find params[:election_id]
    @candidacies = @election.candidacies
  end
end
