object false
child @tag do
  attributes :id, :name
end
child @candidates do
  attributes :id, :firstName, :lastName
end
child @propositions do
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
