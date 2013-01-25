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
      render 'api/v1/propositions/show'
    else
      render text: {errors: @proposition.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
  
  # GET /api/v1/propositions/search
  # params electionIds, tagIds, candidacyIds
  def search
    # query
    conditions = {}
    unless params[:tagIds].blank?
      conditions[:tag_ids.in] = tag_ids = params[:tagIds].split(',')
    end
    unless params[:candidacyIds].blank?
      conditions[:candidacy_id.in] = candidacy_ids = params[:candidacyIds].split(',')
    end
    
    # pagination
    skip = params[:offset] || 0
    limit = 500
    if params[:limit]
      limit = params[:limit].to_i
    end
    @propositions = Proposition.includes(:candidacy).where(conditions).limit(limit).skip(skip)

    # Logging
    Event.create name: 'comparison', candidacy_ids: candidacy_ids, tag_ids: tag_ids, ip_address: request.remote_ip.inspect, user_driven: params[:userDriven]
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
      render 'api/v1/propositions/show'
    else
      render text: {errors: @proposition.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/propositions/1
  def destroy
    @proposition.destroy
    head :ok
  end

  # POST /api/v1/propositions/1/addcomment
  def addcomment
    @comment = @proposition.comments.build text: params[:text]
    @comment.user = current_user
    
    if @comment.save
      render 'api/v1/comments/show'
    else
      render text: {errors: @comment.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/propositions/1/comments
  def comments
    @comments = @proposition.comments.includes(:user)
  end

  # POST /api/v1/propositions/1/addembed
  def addembed
    transform_youtube_url_shortner_links
    @embed = @proposition.embeds.build url: params[:url], title: params[:title]
    if @embed.save
      render 'api/v1/propositions/show'
    else
      render text: {errors: @embed.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/propositions/1/removeembed
  def removeembed
    embed = @proposition.embeds.find params[:embedId]
    if embed.destroy
      head :ok
    else
      render text: {errors: embed.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/propositions/1/removecomment
  def removecomment
    comment = @proposition.comments.find params[:commentId]
    authorize! :destroy, comment
    if comment.destroy
      head :ok
    else
      render text: {errors: comment.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # POST OR DELETE /api/v1/propositions/1/support
  def support
    if request.post?
      user_action = UserAction.find_or_create_by(user_id: current_user.id, proposition_id: @proposition.id, action: 'support')
      head :ok
    elsif request.delete?
      user_action = UserAction.find_by(user_id: current_user.id, proposition_id: @proposition.id, action: 'support')
      user_action.try :destroy
      head :ok
    else
      render text: {errors: "Wrong HTTP method"}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  protected
    def transform_youtube_url_shortner_links
      params[:url] = params[:url].gsub /^http:\/\/youtu.be\/(\w+)$/, 'http://www.youtube.com/watch?v=\\1'
    end
end
