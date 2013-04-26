class Backoffice::PropositionsController < Backoffice::BackofficeController
  
  def index
    @propositions = Array.new
    current_candidate.candidacies.where(election_id: params[:election_id]).each do |candidacy|
      Proposition.where(candidacy_id: candidacy).each do |proposition|
        @propositions << proposition
      end
    end
  end

  def new
  end

  def edit
    @proposition = Proposition.where(:_id => params[:id]).first
  end

end