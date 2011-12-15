object false
child @election do
  attributes :id, :name
  child :candidates do
    attributes :id, :firstName, :lastName
    node :photo do |candidate|
      {sizes: (ImageUploader.new).versions.inject({}) do |hash, (version, url)|
        hash[version] = {url: candidate.photo_url(version)}
        hash
      end}
    end
  end
end