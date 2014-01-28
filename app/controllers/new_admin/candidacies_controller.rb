class NewAdmin::CandidaciesController < AdminController
  def index
    @election = Election.find params[:election_id]
    load_candidates
    @candidacy ||= Candidacy.new
  end

  def create
    @election = Election.find params[:election_id]

    if params[:candidacy][:candidates].empty?
      flash[:error] = "Please choose a candidate to add"
      return respond_with nil, location: new_admin_election_candidacies_path(@election)
    end

    candidate = Candidate.find params[:candidacy][:candidates]

    @candidacy = Candidacy.new election: @election, candidates: [candidate]

    if @candidacy.save
      flash[:notice] = "#{candidate} attends to the election : #{@election}"
      respond_with @candidacy, location: new_admin_election_candidacies_path(@election)
    else
      flash[:error] = "Fail to add #{candidate} to #{@election}"
      render :index
    end
  end

  def destroy
    candidacy = Candidacy.find params[:id]
    candidacy.destroy
    @election = Election.find params[:election_id]
    respond_with nil, location: new_admin_election_candidacies_path(@election)
  end

  def toggle
    candidacy = Candidacy.find params[:candidacy_id]
    candidacy.published = !candidacy.published
    candidacy.save
    @election = Election.find params[:election_id]
    respond_with nil, location: new_admin_election_candidacies_path(@election)
  end

  protected

  def load_candidates
    @candidacies = @election.candidacies.to_a.sort do |c1,c2|
      c1.candidates[0].last_name <=> c2.candidates[0].last_name
    end
    candidates = @candidacies.map{ |c| c.candidates[0]}
    @available_candidates = Candidate.all.to_a.select do |c| !candidates.include? c  end
  end
end
