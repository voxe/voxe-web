object false
child @election do
  attributes :id, :name
  child :themes do
    attributes :id, :name, :position
    child :themes => :categories do
      attributes :id, :name, :position
      child :themes => :sections do
        attributes :id, :name, :position
      end
    end
  end
  child :candidates do
    attributes :id, :firstName, :lastName
  end
end