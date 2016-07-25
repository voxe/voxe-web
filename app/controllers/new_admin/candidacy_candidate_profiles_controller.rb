class NewAdmin::CandidacyCandidateProfilesController < AdminController
  authorize_resource

  def index
    @candidacy_candidate_profiles = CandidacyCandidateProfile.all.desc(:created_at)
    @current_user = current_user
  end

  def edit
    @candidacy_candidate_profile = CandidacyCandidateProfile.find(params[:id])
    @current_user = current_user
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
