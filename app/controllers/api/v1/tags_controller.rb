class Api::V1::TagsController < Api::V1::ApplicationController

  # POST /api/v1/tags
  def create
    if @tag.save
      render 'api/v1/tags/show.rabl', status: :created
    else
      render text: {errors: @tag.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/tags/{id}
  def show
  end

  # GET /api/v1/tags/search
  def search
    @tags = Tag.where(name: /#{params[:name]}/i)
  end

  # PUT /api/v1/tags/{id}
  def update    
    if @tag.update_attributes params[:tag]
      @tag.elections.each do |election|
        expire_action controller: "api/v1/elections", action: "show", id: @tag.election
      end
      
      render 'api/v1/tags/show.rabl'
    else
      render text: {errors: @tag.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

end
