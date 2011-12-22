object false
child @proposition do
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