child @candidate do
  attributes :id, :namespace
  attributes :first_name => :firstName, :last_name => :lastName
  child :candidacies  do
    attributes :id
    child :election do
      attributes :id, :name
    end
  end
end