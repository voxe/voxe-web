code :id do |election_tag|
  election_tag.tag.id
end
code :name do |election_tag|
  election_tag.tag.name
end
code :namespace do |election_tag|
  election_tag.tag.namespace
end
code :position do |election_tag|
  election_tag.position
end
node :icon do |election_tag|
  {prefix: election_tag.tag.icon_prefix, sizes: election_tag.tag.icon_sizes, name: election_tag.tag.icon_name}
end
node :tags, :if => lambda { |election_tag| !election_tag.children_election_tags.empty? } do |election_tag|
  election_tag.children_election_tags.collect do |election_tag|
    partial("api/v1/elections/tag", :object => election_tag)
  end
end