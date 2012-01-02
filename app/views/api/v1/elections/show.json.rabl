object false
child @election do
  attributes :id, :name, :namespace, :path, :published
  # child :parent_election => :parentElection do
  #   attributes :id, :name
  # end
  # child :elections => :elections do
  #   attributes :id, :name
  # end
  child :candidacies do
    attribute :id, :published
    child :organization, :if => lambda { |candidacy| !candidacy.organization.blank? } do
      attribute :id, :name
    end
    child :candidates, :if => lambda { |candidacy| !candidacy.candidates.blank? } do
      attributes :id
      attributes :first_name => :firstName, :last_name => :lastName
      node :photo do |candidate|
        {sizes: (ImageUploader.new).versions.inject({}) do |hash, (version, url)|
          hash[version] = {url: candidate.photo_url(version)}
          hash
        end}
      end
    end
  end
  node :tags do |election|
    election.root_election_tags.collect do |election_tag|
      partial("api/v1/elections/tag", :object => election_tag)
    end
  end
end