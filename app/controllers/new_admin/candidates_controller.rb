class NewAdmin::CandidatesController < AdminController
  load_and_authorize_resource

  def index
  end

  def new
    @candidate.photos.build
  end

  def edit

  end

  def create
    @candidate.attributes = params[:candidate]
    if @candidate.save
      redirect_to action: :index
    else
      render action: :new
    end
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
