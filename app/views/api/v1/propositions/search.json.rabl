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
  child :election do
    attributes :id
  end
  child :candidacy do
    attributes :id
  end
end
