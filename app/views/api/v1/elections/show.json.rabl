object false
child @election do
  attributes :id, :name, :namespace, :path, :published, :date
  # child :parent_election => :parentElection do
  #   attributes :id, :name
  # end
  # child :elections => :elections do
  #   attributes :id, :name
  # end
  child (@only_published_candidacies ? :published_candidacies_sorted : :candidacies_sorted) do
    extends "api/v1/candidacies/base"
  end
  node :tags do |election|
    if @all_tags
      # include all tags
      Api::V1::Formatters::ElectionTags.new(election).all_tags_json
    else
      # only root_tag (default)
      Api::V1::Formatters::ElectionTags.new(election).root_tags_json
    end
  end
end