class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user.admin = params[:user][:admin]
    if @user.save
      redirect_to action: :index, notice: "User was sucessfully created"
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @user.admin = params[:user][:admin]
    if @user.save
      redirect_to action: :index, notice: "User was sucessfully updated"
    else
      render action: :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to action: :index, notice: "User was sucessfully destroyed"
  end

end
