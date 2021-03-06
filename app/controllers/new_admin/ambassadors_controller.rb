# encoding: UTF-8
class NewAdmin::AmbassadorsController < AdminController
  authorize_resource class: false
  before_filter :load_election
  before_filter :load_ambassadors

  def index
    @users = User.all.sort_by{ |u|  u.name}
  end

  def create
    if user = User.find(params[:user_id])
      exist = false
      @election.ambassadors.each do |e|
        if e.id == user.id
          exist = true
          break
        end
      end
      if !exist
        @election.ambassadors << user 
        UserMailer.admin_ambassador_granted(user, @election).deliver
        flash[:notice] = "The new ambassador has been created"
      else
        flash[:error] = "this user is already ambassador of this election"
      end
        redirect_to action: :index
    end
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
