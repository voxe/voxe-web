collection @events => :comparisons
attributes :id
node :createdAt do |comparison|
  comparison.created_at.to_i
end
child :candidacies do
  extends "api/v1/candidacies/base"
end
child :tags do
  extends "api/v1/tags/base"
end