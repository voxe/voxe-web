class NewAdmin::TagsController < AdminController
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
end
