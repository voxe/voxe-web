object false
child @candidate do
  attributes :first_name => :firstName, :last_name => :lastName
  child :elections do
    attributes :id, :name
  end
end