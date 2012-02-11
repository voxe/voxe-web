child @candidacy do
  extends "api/v1/candidacies/base"
  child :election do
    attributes :id, :name
  end
end
