class NewAdmin::TagsController < AdminController
  authorize_resource

  def index
    @tags = Tag.asc(:name)
  end

  def create
    @tag = Tag.new name: params[:tag][:name]
    if @tag.save
      flash[:notice] = "#{@tag.name} has been created !"
    else
      flash[:error] = "#{@tag.name} creation has failed : #{@tag.errors.full_messages.join(', ')}"
    end
    redirect_to :back
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
