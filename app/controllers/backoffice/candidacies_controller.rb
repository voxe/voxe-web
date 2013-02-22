class Backoffice::CandidaciesController < ApplicationController
  load_and_authorize_resource class: 'Candidacy'
  before_filter :load_election
  layout 'backoffice'

  def show
  end

  private

  def load_election
    @election = @candidacy.election
  end
end
