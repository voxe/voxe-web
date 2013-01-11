class Api::V1::UsersController < Api::V1::ApplicationController
  
  # GET /api/v1/users/self
  def self
    @user = current_user
    render 'api/v1/users/show'
  end
  
  # GET /api/v1/users/search
  def search
    @users = User.where name: /#{params[:name]}/i
  end

  # POST /api/v1/users
  def create
    if @user.save
      render 'api/v1/users/show', status: :created
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # POST /api/v1/users/facebookconnect
  def facebookconnect
    if @user = User.find_for_facebook_token(params[:facebookToken])
      render 'api/v1/users/show'
    else
      render text: {errors: {user: "wrong facebook token"}}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/users/verify
  def verify
    if @user = User.find_for_database_authentication(email: params[:email]) and @user.valid_password? params[:password]
      render 'api/v1/users/show'
      # On every request just add the parameter "auth_token"
    else
      render text: {errors: {user: "wrong email or password"}}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    if @user.destroy
      head :ok
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # PUT /api/v1/users/:id/addadmin
  def addadmin
    @user.admin = true
    if @user.save
      render 'api/v1/users/show'
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # PUT /api/v1/users/:id/addadmin
  def removeadmin
    @user.admin = false
    if @user.save
      render 'api/v1/users/show'
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/users/admins
  def admins
    @users = User.where admin: true
  end
end
