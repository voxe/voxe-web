class NewAdmin::TagsController < AdminController
  def index
    @tags = Tag.asc(:name)
  end

  def create
    @tag = Tag.new name: params[:tag][:name]
    if @tag.save
      flash[:notice] = "#{@tag.name} has been created !"
    else
      flash[:error] = "#{@tag.name} creation has failed : #{@tag.errors.inspect}"
    end
    election = Election.find params[:election]
    respond_with [:new_admin, @tag], location: new_admin_election_election_tags_path(election)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes params[:tag]
      redirect_to new_admin_tags_path
    else
      render action: :edit
    end
  end
end
