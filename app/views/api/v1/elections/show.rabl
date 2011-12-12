object false
child @election do
  attributes :id, :name
  child :themes do
    attributes :id, :name, :position
    child :themes do
      attributes :id, :name, :position
      child :themes do
        attributes :id, :name, :position
      end
    end
  end
  child :candidates do
    attributes :id, :firstName, :lastName
    child :photo, :if => lambda { |c| c.photo? } do
      attributes :id
      node(:sizes) do |photo|
        photo.image.versions.inject({}) do |hash, (version, url)|
          hash[version] = url
          hash
        end
      end
    end
  end
end