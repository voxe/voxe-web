object false
child @tag do
  attributes :id, :name
end
child @candidates do
  attributes :id, :firstName, :lastName
end
child @propositions do
  attributes :id, :text
  node :tags
    attributes :id
  end
  node(:candidate) do |proposition|
    {id: proposition.candidateId}
  end
end
