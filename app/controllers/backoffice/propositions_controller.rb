class Backoffice::PropositionsController < Backoffice::BackofficeController
  def index
    @elections = Array.new
    @propositions = Array.new

    # candidate will be replaced by current_candidate
    @candidate = Candidate.where(:_id => "4ef479fdbc60fb0004000264").first # test candidate - Nicolas Sarkozy

    @candidate.candidacy_ids.each do |candidacy| # for every candidacy of the candidate
      
      # get the election linked to that candidacy
      @tmp = Election.where( :_id => Candidacy.where(:_id => candidacy).first.election_id).first 
      if !@elections.include?(@tmp) # checking because TWO candidacies can be linked to ONE election
        @elections << @tmp
      end

      # get all the propositions linked to that candidacy
      Proposition.where(:candidacy_id => candidacy).each do |prop|
        @propositions << prop
      end
    end
  end

end