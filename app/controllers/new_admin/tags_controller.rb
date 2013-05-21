class NewAdmin::TagsController < AdminController
  load_resource

  def index
    @tags = @tags.order_by name: :asc
  end

  def create
    @tag = Tag.new params[:tag]
    if @tag.save
      flash[:notice] = @tag.to_s + " has correctly been created"
    else
      flash[:error] = @tag.to_s + " has been destroyed"
    end

    respond_with @tag, location: new_admin_tags_path
  end
end
