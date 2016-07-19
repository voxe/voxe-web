class NewAdmin::CandidatesController < AdminController
  load_and_authorize_resource

  def index
  end

  def new
    @candidate.photos.build
  end

  def edit
    @no_namespace = true
  end

  def create
    @candidate.attributes = params[:candidate]
    if @candidate.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def destroy
    candidate = Candidate.find params[:id]
    if candidate.destroy
      flash[:notice] = "Le candidat a bien été supprimé"
    else
      flash[:error] = "Une erreur est survenue lors de la suppression du candidat, veuillez réessayer"
    end
    redirect_to :back
  end

  def update

    @candidate.attributes = params[:candidate]
    if @candidate.save
      redirect_to action: :index
    else
      render action: :edit
    end
  end
end
