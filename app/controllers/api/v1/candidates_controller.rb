class Api::V1::CandidatesController < Api::V1::ApplicationController

  # POST /api/v1/candidates
  def create
    if @candidate.save
      render 'api/v1/candidates/show.rabl', status: :created
    else
      render json: {errors: @candidate.errors}, status: :unprocessable_entity
    end
  end

  # GET /api/v1/candidates/1
  def show
  end

  # POST /api/v1/candidates/1/addphoto
  def addphoto
    photo = @candidate.photos.build image: params[:image]

    if photo.save
      render text: {photo: photo}.to_json, status: :created, layout: 'api_v1'
    else
      render text: {errors: photo.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end

  # GET /api/v1/candidates/search
  def search
    @candidates = Candidate.any_of({first_name: /#{params[:name]}/i}, {last_name: /#{params[:name]}/i}).order_by([[:first_name, :asc], [:last_name, :desc]])
  end
end
