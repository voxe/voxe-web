class CandidaciesComparison
  # TODO Cache system
  def self.most_compared_list candidacy
    other_candidacies = candidacy.election.candidacies.published.where(:id.ne => candidacy.id)
    results = {}
    other_candidacies.each do |other_candidacy|
      results[other_candidacy] = Event.all(candidacy_ids: [candidacy.id, other_candidacy.id]).count
    end
    results.sort_by {|candidacy,counter| -counter}
  end

end
