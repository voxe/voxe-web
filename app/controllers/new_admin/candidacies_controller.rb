class NewAdmin::CandidaciesController < AdminController
  def index
    @election = Election.find params[:election_id]
    @candidates = @election.candidacies.map{|c| c.candidates[0]}.sort do |c1,c2| 
      c1.last_name <=> c2.last_name
    end
    @candidacy ||= Candidacy.new
    @available_candidates = Candidate.all.to_a.select do |c| !@candidates.include? c  end
  end
end
