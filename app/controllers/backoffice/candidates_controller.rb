class Backoffice::CandidatesController < Backoffice::BackofficeController
  def show
    redirect_to action: :edit
  end

  def edit
  end

  def update
    current_candidate.update_attributes params[:candidate]
    respond_with current_candidate, location: backoffice_candidate_path
  end

end