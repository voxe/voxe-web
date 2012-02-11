collection @events => :comparisons
attributes :id
attributes :created_at => :createdAt
child :candidacies do
  extends "api/v1/candidacies/base"
end
child :tags do
  extends "api/v1/tags/base"
end