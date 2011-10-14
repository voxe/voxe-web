class Api::V1::CandidatesController < ApplicationController

  # POST /api/v1/candidates
  def create
    @candidate = Candidate.new(params[:candidate])

    if @candidate.save
      render json: {candidate: @candidate}
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

end