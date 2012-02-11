child @candidate do
  attributes :namespace
  extends "api/v1/candidates/base"
  child :candidacies  do
    attributes :id
    child :election do
      attributes :id, :name
    end
  end
end