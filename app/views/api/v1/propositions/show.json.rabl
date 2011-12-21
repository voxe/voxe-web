object false
child @proposition do
  attributes :id, :text
  child :tags do
    attributes :id
  end
  node(:election) do |proposition|
    {id: proposition.election_id}
  end
  node(:candidate) do |proposition|
    {id: proposition.candidate_id}
  end
end