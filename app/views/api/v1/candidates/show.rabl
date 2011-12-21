object false
child @candidate do
  attributes :id
  attributes :first_name => :firstName, :last_name => :lastName
  child :elections => :elections do
    attributes :id, :name
  end
end