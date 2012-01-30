collection @comments
attributes :id, :text
child :user do
  attributes :id, :name
end