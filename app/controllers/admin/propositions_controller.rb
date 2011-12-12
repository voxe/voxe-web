class Admin::PropositionsController < ApplicationController
  layout 'backoffice'
  load_and_authorize_resource

  def index
    @elections = Election.all
  end

  def manage
    @election = Election.find params[:manage][:electionId]
    @candidate = Candidate.find params[:manage][:candidateId]
    @section = Theme.find params[:manage][:sectionId]
  end

  def create
    if @proposition.save
      flash[:notice] = "Your proposition was successfully created"
    else
      flash[:alert] = "Something went wrong while saving your proposition"
    end
    redirect_to :back
  end

  def update
    if @proposition.update_attributes params[:proposition]
      flash[:notice] = "Your proposition was successfully updated"
    else
      flash[:alert] = "Something went wrong while saving your proposition"
    end
  end

  def destroy
    # TODO
  end
end
