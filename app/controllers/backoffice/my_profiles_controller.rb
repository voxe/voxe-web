class Backoffice::MyProfilesController < Backoffice::BackofficeController
  before_filter :load_candidate
  load_and_authorize_resource :candidate

  def show
    redirect_to action: :edit
  end

  def edit
  end

  def update
    current_candidate.update_attributes params[:candidate]
    respond_with current_candidate, location: backoffice_my_profile_path
  end

  protected
  def load_candidate
    @candidate ||= current_candidate
  end
end