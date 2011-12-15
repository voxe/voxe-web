class Admin::TagsController < ApplicationController
  load_and_authorize_resource
  layout 'backoffice'

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @tag.save
      flash[:notice] = "Your have successfully created a tag."
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def update
    if @tag.update_attributes params[:tag]
      flash[:notice] = "You have successfully updated a tag."
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
end
