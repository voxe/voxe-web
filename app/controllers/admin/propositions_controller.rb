class Admin::PropositionsController < ApplicationController
  layout 'backoffice'
  load_and_authorize_resource

  def index
    @elections = Election.all
  end

  def manage
    @election = Election.find params[:electionId]
    @candidate = Candidate.find params[:candidateId]
    @propositions = Proposition.where electionId: @election.id, candidateId: @candidate.id
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
    @proposition.update_attributes params[:proposition]
  end

  def destroy
    # TODO
  end
end
