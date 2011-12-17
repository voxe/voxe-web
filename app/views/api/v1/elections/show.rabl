object false
child @election do
  attributes :id, :name
  child :candidates do
    attributes :id
    attributes :first_name => :firstName, :last_name => :lastName
    node :photo do |candidate|
      {sizes: (ImageUploader.new).versions.inject({}) do |hash, (version, url)|
        hash[version] = {url: candidate.photo_url(version)}
        hash
      end}
    end
  end
  node :tags do |election|
    election.root_election_tags.collect do |election_tag|
      partial("api/v1/elections/tag", :object => election_tag)
    end
  end
end