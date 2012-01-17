object false
collection @elections => :elections
attributes :id, :name, :namespace, :published
child :candidacies do
  attribute :id, :published, :namespace
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