# encoding: UTF-8
class NewAdmin::ContributorsController < AdminController
  authorize_resource class: false
  before_filter :load_election
  before_filter :load_contributors

  def index
    @users = User.all.sort_by{ |u|  u.name}
  end

  def create
    if user = User.find(params[:user_id])
      exist = false
      @election.contributors.each do |e|
        if e.id == user.id
          exist = true
          break
        end
      end
      if !exist
        @election.contributors << user 
        UserMailer.admin_contributor_granted(user, @election).deliver
        flash[:notice] = "The new contributor has been added"
      else
        flash[:error] = "The selected user is already contributor of this election"
      end
        redirect_to action: :index
    end
  end

  def destroy
    user = User.find(params[:id])
    @election.contributors.delete user
    redirect_to action: :index
  end

  private

  def load_election
    @election = Election.find(params[:election_id])
  end

  def load_contributors
    @contributors = @election.contributors
  end
end
