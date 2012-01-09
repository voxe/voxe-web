class Api::V1::PropositionsController < Api::V1::ApplicationController

  # POST /api/v1/propositions
  def create
    params[:proposition] ||= {}
    tags = Tag.any_in(_id: params[:proposition][:tagIds].split(',')) if params[:proposition][:tagIds]
    @proposition = Proposition.new(
      text:         params[:proposition][:text],
      candidacy_id: params[:proposition][:candidacyId],
      tags:          tags
    )

    if @proposition.save
      render 'api/v1/propositions/show.rabl'
    else
      render text: {errors: @proposition.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
  
  # GET /api/v1/propositions/search
  # params electionIds, tagIds, candidacyIds
  def search
    # query
    conditions = {}
    conditions[:tag_ids.in] = params[:tagIds].split(',') unless params[:tagIds].blank?
    conditions[:candidacy_id.in] = params[:candidacyIds].split(',') unless params[:candidacyIds].blank?
    
    # pagination
    skip = params[:offset] || 0
    @propositions = Proposition.where(conditions).limit(500).skip(skip)
  end
  
  # GET /api/v1/propositions
  def show
  end

end
