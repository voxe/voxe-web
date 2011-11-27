object false
child @candidate do
  attributes :id, :firstName, :lastName
  child :elections do
    attributes :id, :name
  end
end