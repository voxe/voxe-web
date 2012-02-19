attributes :id, :name
node :picture, :if => lambda { |user| user.picture? } do |user|
  user.picture
end