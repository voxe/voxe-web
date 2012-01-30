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
    @propositions = Proposition.includes(:candidacy).where(conditions).limit(500).skip(skip)
  end
  
  # GET /api/v1/propositions
  def show
  end

  # PUT /api/v1/propositions/1
  def update
    params[:proposition] ||= {}
    if params[:proposition][:tagIds]
      @proposition.tags = Tag.any_in(_id: params[:proposition][:tagIds].split(','))
    end
    if params[:proposition][:text]
      @proposition.text = params[:proposition][:text]
    end

    if @proposition.save
      render 'api/v1/propositions/show.rabl'
    else
      render text: {errors: @proposition.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/propositions/1
  def destroy
    @proposition.destroy
    head :ok
  end

  # POST /api/v1/proposition/1/addcomment
  def addcomment
    @comment = @proposition.comments.build params[:comment]
    @comment.user = current_user

    if @comment.save
      head :ok
    else
      render text: {errors: @comment.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
end
