class Backoffice::ElectionsController < Backoffice::BackofficeController

  def index
    @elections = Array.new
    current_candidate.candidacies.each do |candidacy|
      if !@elections.include?(candidacy.election)
        @elections << candidacy.election
      end
    end
  end

end