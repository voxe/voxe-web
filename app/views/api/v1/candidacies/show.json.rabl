child @candidacy do
  attributes :id
  attributes :name
  child :candidates do
    attributes :id
    attributes :first_name => :firstName, :last_name => :lastName
  end
  child :election do
    attributes :id, :name
  end
end
