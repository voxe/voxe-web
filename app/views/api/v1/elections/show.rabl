object false
child @election do
  attributes :id, :name
  child :themes do
    attributes :id, :name, :position
    node :photo do |theme|
      {sizes: (ImageUploader.new).versions.inject({}) do |hash, (version, url)|
        hash[version] = {url: theme.photo_url(version)}
        hash
      end}
    end
    child :themes do
      attributes :id, :name, :position
      child :themes do
        attributes :id, :name, :position
      end
    end
  end
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