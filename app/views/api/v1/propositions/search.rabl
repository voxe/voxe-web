object false
child @theme do
  attributes :id, :name, :position
  child :themes do
    attributes :id, :name, :position
    child :themes do
      attributes :id, :name, :position
    end
  end
end
child @candidates do
  attributes :id, :firstName, :lastName
end
child @propositions do
  attributes :id, :text
  node(:theme) do |proposition|
    {id: proposition.themeId}
  end
  node(:candidate) do |proposition|
    {id: proposition.candidateId}
  end
end