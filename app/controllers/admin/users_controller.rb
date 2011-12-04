class Admin::UsersController < ApplicationController
  layout 'backoffice'
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @user.admin = params[:user][:admin]
    if @user.save
      flash[:notice] = "User was sucessfully created"
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @user.admin = params[:user][:admin]
    if @user.save
      flash[:notice] = "User was sucessfully updated"
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User was sucessfully destroyed"
    redirect_to action: :index
  end

end
