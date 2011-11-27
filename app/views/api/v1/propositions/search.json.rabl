object false
child @theme do
  attributes :id, :name, :position
  child :themes => :categories do
    attributes :id, :name, :position
    child :themes => :sections do
      attributes :id, :name, :position
    end
  end
end
child @candidates do
  attributes :id, :name
end
child @propositions do
  attributes :id, :text, :candidateId
  node(:sectionId) do |proposition|
    proposition.themeId
  end
end