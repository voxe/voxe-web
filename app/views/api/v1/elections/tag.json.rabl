code :id do |election_tag|
  election_tag.tag.id
end
code :name do |election_tag|
  election_tag.tag.name
end
code :position do |election_tag|
  election_tag.position
end
node :icon do
  {prefix: "/images/icons/tag_".to_url, sizes: [32, 64, 256], name: ".png"}
end
node :tags, :if => lambda { |election_tag| !election_tag.children_election_tags.empty? } do |election_tag|
  election_tag.children_election_tags.collect do |election_tag|
    partial("api/v1/elections/tag", :object => election_tag)
  end
end