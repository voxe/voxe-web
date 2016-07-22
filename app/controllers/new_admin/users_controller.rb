class NewAdmin::UsersController < AdminController
  load_and_authorize_resource

  def index
    if params[:search].present?
      @users = @users.or(name: /#{params[:search]}/i).or(email: /#{params[:search]}/i)
    end
    @users = @users.desc(:created_at).paginate(:page => params[:page], :per_page => 20)
  end
end
