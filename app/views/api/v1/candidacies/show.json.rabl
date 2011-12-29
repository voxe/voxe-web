child @candidacy do
  attributes :id, :published
  child :candidates do
    attributes :id
    attributes :first_name => :firstName, :last_name => :lastName
  end
  child :election do
    attributes :id, :name
  end
end
