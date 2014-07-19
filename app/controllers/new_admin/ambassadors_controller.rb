class NewAdmin::AmbassadorsController < AdminController
  authorize_resource class: false
  before_filter :load_election
  before_filter :load_ambassadors

  def index

  end

  def create
    if user = User.find_by(email: params[:email])
      @election.ambassadors << user
      UserMailer.admin_ambassador_granted(user, @election).deliver
    else
      flash[:alert] = "Can't find this user"
    end
    redirect_to action: :index
  end

  def destroy
    user = User.find(params[:id])
    @election.ambassadors.delete user
    redirect_to action: :index
  end

  private

  def load_election
    @election = Election.find(params[:election_id])
  end

  def load_ambassadors
    @ambassadors = @election.ambassadors
  end
end
