class Api::V1::PropositionsController < ApplicationController
  
  load_and_authorize_resource
  skip_before_filter :verify_authenticity_token

  # POST /api/v1/propositions
  def create
    if @proposition.save
      render 'api/v1/propositions/show.rabl'
    else
      render json: {errors: @proposition.errors}, status: :unprocessable_entity
    end
  end
  
  # GET /api/v1/propositions/search
  # params electionId, tagIds, candidateIds
  def search
    # query
    conditions = {}
    conditions[:tag_ids.in] = params[:tagIds].split(',') unless params[:tagIds].blank?
    conditions[:election_id.in] = params[:electionIds].split(',') unless params[:electionIds].blank?
    conditions[:candidate_id.in] = params[:candidateIds].split(',') unless params[:candidateIds].blank?
    
    # pagination
    skip = params[:offset] || 0
    @propositions = Proposition.where(conditions).limit(500).skip(skip)
  end
  
  # GET /api/v1/propositions
  def show
  end

end
