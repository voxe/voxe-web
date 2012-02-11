object false
child @organization do
  extends "api/v1/organizations/base"
  child :candidacies do
    attributes :id
  end
end
