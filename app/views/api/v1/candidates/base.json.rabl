attributes :id, :namespace
attributes :firstName, :lastName
node :photo do |candidate|
  {sizes: (ImageUploader.new).versions.inject({}) do |hash, (version, url)|
    hash[version] = {url: candidate.photo_url(version)}
    hash
  end}
end