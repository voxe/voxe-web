class NewAdmin::ElectionsController < AdminController
  load_resource

  def index
    @elections = @elections.order_by name: :asc
  end

  def edit
  end

  def new
  end

  def create
    @election.contributors << current_user
    if @election.save
      flash[:notice] = "#{@election} has been saved."
      @election.copy_tags_from_election(Election.find params[:election][:election_tags])
    end
    respond_with :new_admin, @election, location: new_admin_elections_path
  end

  def show
    @election_tags = @election.election_tags.
      select{|et| et.root? }.
      sort{|et1,et2| et1.tag.name <=> et2.tag.name}
  end

  def update
    @election.update_attributes(params[:election])
    respond_with :new_admin, @election, location: new_admin_elections_path
  end

  def destroy
    if @election.destroy
      flash[:notice] = @election.to_s + " has been deleted."
    else
      flash[:error] = "An error occured while deleting" + @election.to_s
    end
    respond_with :new_admin, @election, location: new_admin_elections_path
  end

  def publish
    toggle_publication("publish", true)
  end

  def unpublish
    toggle_publication("unpublish", false)
  end

  private

  def toggle_publication(action_name, state)
    @election = Election.find(params["election_id"])
    @election.published = state
    if @election.save
      flash[:notice] = @election.to_s + " has been " + action_name + "ed."
    else
      flash[:error] = "An error occured while " + action_name + "ing " + @election.to_s
    end
    respond_with @election, location: new_admin_elections_path
  end
end
