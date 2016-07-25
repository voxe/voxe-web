# encoding: UTF-8
class NewAdmin::TagsController < AdminController
  authorize_resource

  def index
    @tags = Tag.asc(:name).paginate(:page => params[:page], :per_page => 30)
  end


  def create
    @tag = Tag.new params[:tag]
    @tag.name = @tag.name.upcase
    if @tag.save
      flash[:notice] = "#{@tag.name} has been created !"
      redirect_to new_admin_tags_path
    else
      flash[:error] = "The tag could not be created : #{@tag.errors.full_messages.join(', ')}"
      redirect_to :back
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.attributes params[:tag]
    @tag.name = @tag.name.upcase
    if @tag.save
      flash[:notice] = "#{@tag.name} has been updated"
      redirect_to new_admin_tags_path
    else
      flash[:error] = "The  tag could not be updated : #{@tag.errors.full_messages.join(', ')}"
      redirect_to :back
    end
  end
end
