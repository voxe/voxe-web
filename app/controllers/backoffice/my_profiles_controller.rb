class Backoffice::MyProfilesController < Backoffice::BackofficeController
  before_filter :load_profile

  def show
    if @profile.nil?
      redirect_to action: :new
    else
      redirect_to action: :edit
    end
  end

  def new
    @profile = CandidacyCandidateProfile.new
  end

  def create
    @profile = current_candidacy.create_candidate_profile(params[:candidacy_candidate_profile])
    respond_with @profile, location: backoffice_my_profile_path
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
