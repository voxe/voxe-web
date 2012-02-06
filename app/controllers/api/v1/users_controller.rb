class Api::V1::UsersController < Api::V1::ApplicationController
  
  # GET /api/v1/users/self
  def self
    @user = current_user
    render 'api/v1/users/show.rabl'
  end
  
  # GET /api/v1/users/search
  def search
    @users = User.where name: /#{params[:name]}/i
  end

  # POST /api/v1/users
  def create
    if @user.save
      render 'api/v1/users/show.rabl', status: :created
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/users/verify
  def verify
    if @user = User.find_for_database_authentication(email: params[:email]) and @user.valid_password? params[:password]
      render 'api/v1/users/show.rabl'
      # On every request just add the parameter "auth_token"
    else
      render text: {errors: {user: "wrong email or password"}}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
end
