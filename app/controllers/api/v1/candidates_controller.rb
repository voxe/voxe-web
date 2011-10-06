class Api::V1::CandidatesController < ApplicationController

  # POST /api/v1/candidates
  def create
    @candidate = Candidate.new(params[:candidate])

    if @candidate.save
      head :ok
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

end
