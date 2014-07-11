class NewAdmin::CandidacyCandidateProfilesController < AdminController
  authorize_resource

  def index
    @candidacy_candidate_profiles = CandidacyCandidateProfile.all
  end

  def edit
    @candidacy_candidate_profile = CandidacyCandidateProfile.find(params[:id])
  end

  def update
    @candidacy_candidate_profile = CandidacyCandidateProfile.find(params[:id])
    if @candidacy_candidate_profile.update_attributes params[:candidacy_candidate_profile]
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
