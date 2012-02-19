attributes :id, :name
attributes :picture, :if => lambda { |user| user.picture? }