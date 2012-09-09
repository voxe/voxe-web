object false
collection @elections => :elections
attributes :id, :name, :namespace, :published, :date
child (@only_published_candidacies ? :published_candidacies_sorted : :candidacies_sorted) do
  extends "api/v1/candidacies/base"
end
child :country do
  attributes :name, :namespace
end
child :root_election_tags => :tags do
  attribute :position
  glue :tag do
    extends "api/v1/tags/base"
  end
end