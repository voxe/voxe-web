code :id do |election_tag|
  election_tag.tag.id
end
code :name do |election_tag|
  election_tag.tag.name
end
code :position do |election_tag|
  election_tag.position
end
node :icon, :if => lambda { |election_tag| !election_tag.parent_tag } do |election_tag|
  {sizes: (IconUploader.new).versions.inject({}) do |hash, (version, url)|
    hash[version] = {url: election_tag.tag.icon_url(version).to_url}
    hash
  end}
end
node :tags, :if => lambda { |election_tag| !election_tag.children_election_tags.empty? } do |election_tag|
  election_tag.children_election_tags.collect do |election_tag|
    partial("api/v1/elections/tag", :object => election_tag)
  end
end