class Api::V1::ElectionsController < ApplicationController
  
  def index
  end
  
  # GET /api/v1/elections/1
  # 
  def show
    # @election = Election.find(params[:id])
    # 
    # respond_to do |format|
    #   format.json { render json: @election }
    # end
  end

  # POST /elections
  def create
    @election = Election.new(params[:election])

    respond_to do |format|
      if @election.save
        format.json { render json: @election, status: :created, location: @election }
      else
        format.json { render json: @election.errors, status: :unprocessable_entity }
      end
    end
  end

end
