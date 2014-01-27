class Api::V1::ElectionsController < Api::V1::ApplicationController

  #caches_action :show, :expires_in => 1.hour
  caches_action :search, expires_in: 300.seconds, if: Proc.new { params[:published].blank? && params[:name].blank? }, layout: false
  caches_action :show, expires_in: 3600.seconds, if: Proc.new { params[:published].blank? }, layout: false

  # GET /api/v1/elections/1
  def show
    @all_tags = true # since we use caching #(params[:tags] == 'all')
    @only_published_candidacies = not(params[:published] == 'all')
  end

  # GET /api/v1/elections/search
  def search
    @only_published_candidacies = false
    unless params[:published] == 'all'
      @elections = @elections.where(published: true)
      @only_published_candidacies = true
    end
    @elections = @elections.where(parent_election_id: params[:parent], name: /#{params[:name]}/i).includes(:candidacies).limit(30)
  end

  # POST /api/v1/elections
  def create
    @election.contributors << current_user

    if @election.save
      render 'api/v1/elections/show', status: :created
    else
      render text: {errors: @election.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # PUT /api/v1/elections/1
  def update
    if @election.update_attributes params[:election]
      #expire_action action: "show", id: @election.id

      render 'api/v1/elections/show', status: :ok
    else
      render text: {errors: @election.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # POST /api/v1/elections/1/addtag
  def addtag
    tag = Tag.find params[:tagId]
    if params[:parentTagId]
      parent_tag = Tag.find params[:parentTagId]
    end

    @election_tag = ElectionTag.new election: @election, tag: tag, parent_tag: parent_tag

    if @election_tag.save
      #expire_action action: "show", id: @election.id
      render 'api/v1/elections/show', status: :created
    else
      render text: {errors: @election_tag.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # POST /api/v1/elections/1/addcandidacy
  def addcandidacy
    candidates = params[:candidateIds].split(',').collect {|id| Candidate.find(id) }
    @election.candidacies.build candidates: candidates

    if @election.save
      #expire_action action: "show", id: @election.id
      render 'api/v1/elections/show', status: :created
    else
      render text: {errors: @election.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # DELETE /api/v1/elections/1/removetag
  def removetag
    @election.election_tags.where(tag_id: params[:tagId]).destroy_all
    #expire_action action: "show", id: @election.id
    head :ok
  end

  # POST /api/v1/elections/1/movetags
  def movetags
    params[:tagIds].each_with_index do |tag_id, index|
      tag = Tag.find tag_id
      et = ElectionTag.where(election_id: @election.id, tag_id: tag.id).first
      et.update_attribute :position, index+1
    end
    render 'api/v1/elections/show', status: :ok
  end

  # POST /api/v1/elections/1/addcontributor
  def addcontributor
    @user = User.find(params[:userId])
    @election.contributors << @user
    @election.save
    if @election.save
      render 'api/v1/users/show'
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/elections/1/contributors
  def contributors
    @users = @election.contributors
  end

  # POST /api/v1/elections/1/addambassador
  def addambassador
    @user = User.find(params[:userId])
    @election.ambassadors << @user
    if @election.save
      render 'api/v1/users/show'
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/elections/1/contributors
  def ambassadors
    @users = @election.ambassadors
  end

end
