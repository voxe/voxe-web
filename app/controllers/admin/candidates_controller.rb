class Admin::CandidatesController < ApplicationController
  layout 'backoffice'
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
    @candidate.photos.build
  end

  def create
    if @candidate.save
      flash[:notice] = "You have successfully created a candidate. Now add him in an election."
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end

  def update
    if @candidate.update_attributes params[:candidate]
      flash[:notice] = "You have successfully updated a candidate."
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
end
