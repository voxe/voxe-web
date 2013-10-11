class Web::CandidacyCandidateProfilesController < Web::ApplicationController
  def show
    @election = Election.find_by(namespace: params[:electionnamespace])
    @candidate = Candidate.find_by(namespace: params[:candidatenamespace])
    @candidacy = @candidate.candidacies.find_by(election_id: @election.id)
    @profile = @candidacy.candidate_profile
  end
end
