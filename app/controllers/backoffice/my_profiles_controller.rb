class Backoffice::MyProfilesController < Backoffice::BackofficeController
  skip_before_filter :authenticate_user!, only: [:new, :create, :thank_you]
  before_filter :load_profile, only: [:show, :edit, :update]

  def show
    if @profile.nil?
      render text: "Profile under validation"
    else
      redirect_to action: :edit
    end
  end

  def new
    redirect_to :show if user_signed_in?
    @profile = CandidacyCandidateProfile.new
  end

  def create
    redirect_to :show if user_signed_in?
    @profile = CandidacyCandidateProfile.new params[:candidacy_candidate_profile]
    if @profile.save
      redirect_to thank_you_backoffice_my_profile_path
    else
      render action: :new
    end
  end

  def thank_you
  end

  def edit
  end

  def update
    @profile.update_attributes params[:candidacy_candidate_profile]
    respond_with @profile, location: backoffice_my_profile_path
  end

  protected

  def load_profile
    if user_signed_in?
      @profile ||= current_user.candidacy_candidate_profile
    end
  end
end
