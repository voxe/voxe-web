class Backoffice::MyProfilesController < Backoffice::BackofficeController
  before_filter :load_profile
  #load_and_authorize_resource :candidacy_candidate_profile

  def show
    redirect_to action: :edit
  end

  def edit
  end

  def update
    @profile.update_attributes params[:candidacy_candidate_profile]
    respond_with @profile, location: backoffice_my_profile_path
  end

  protected
  def load_profile
    @profile ||= CandidacyCandidateProfile.where(:candidacy_id => current_candidacy._id).first
  end
end
