class TagsComparison
  # TODO Cache system
  def self.most_compared_for_candidacy candidacy
    results = {}
    candidacy.election.root_election_tags.map do |et|
      results[et] = Event.where(candidacy_ids: candidacy.id, tag_ids: et.tag_id).count
    end
    results.sort_by {|et,count| -count}
  end

end
