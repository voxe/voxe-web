class Backoffice::MyProfilesController < Backoffice::BackofficeController
  def show
    redirect_to action: :edit
  end

  def edit
  end

  def update
    current_candidate.update_attributes params[:candidate]
    respond_with current_candidate, location: backoffice_my_profile_path
  end

end