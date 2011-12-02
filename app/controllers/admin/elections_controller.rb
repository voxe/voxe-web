class Admin::ElectionsController < ApplicationController
  layout 'backoffice'
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @election.save
      flash[:notice] = "You have successfully created an election"
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def update
    if @election.update_attributes params[:election]
      flash[:notice] = "You have successfully updated this election"
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
end
