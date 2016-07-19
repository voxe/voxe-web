class NewAdmin::ElectionsController < AdminController
  load_and_authorize_resource find_by: :namespace

  def index
    @future_elections = load_elections(false)
    @past_elections = load_elections(true)
  end

  def edit
  end

  def new
  end

  def create
    @election.contributors << current_user
    if @election.save
      flash[:notice] = "#{@election} a bien été créée."
      if from_election = Election.where(id: params[:election][:election_tags]).first
        @election.copy_tags_from_election(from_election)
      end
    end
    respond_with :new_admin, @election, location: new_admin_elections_path
  end

  def tags
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
      flash[:notice] = @election.to_s + " a été supprimée."
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
    #respond_with @election, location: new_admin_elections_path
  end

  def load_elections(is_past)
    @elections.asc(:date).select{ |e| 
      if !e.date.blank? 
        if is_past
          (e.date < Date.today) 
        else
          (e.date > Date.today) 
        end
      else 
        false 
      end
      }
  end
end
