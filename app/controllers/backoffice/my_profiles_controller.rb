class Backoffice::MyProfilesController < Backoffice::BackofficeController
  skip_before_filter :authenticate_user!, only: [:new, :create, :thank_you]
  before_filter :load_profile, only: [:show, :edit, :update]

  def show
    @no_signed = true
    unless @profile.nil?
      redirect_to action: :edit
    end
  end

  def new
    redirect_to action: :show if user_signed_in?
    @profile = CandidacyCandidateProfile.new
  end

  def create
    redirect_to :show if user_signed_in?
    @profile = CandidacyCandidateProfile.new params[:candidacy_candidate_profile]
    existing_profile = CandidacyCandidateProfile.where(email: @profile.email)
    if existing_profile.count == 0

      if @profile.save
        redirect_to thank_you_backoffice_my_profile_path
      else
        redirect_to :back, alert: t('backoffice.my_profile_sign_up_error')
      end
    else
      redirect_to :back, alert: t('backoffice.my_profile_existing_email')
    end
  end

  def thank_you
  end

  def edit
    @election = @profile.candidacy.election
  end

  def update
    @profile.update_attributes params[:candidacy_candidate_profile]
    flash[:notice] = "Votre profil a été mis à jour"
    respond_with @profile, location: backoffice_my_profile_path
  end

end
