class NewAdmin::CandidatesController < AdminController
  load_resource :candidate

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
