object false
child @proposition do
  attributes :id, :text
  child :tags do
    attributes :id
  end
  child :candidacy do
    attributes :id
  end
  node :comments_count do |proposition|
    proposition.comments.count
  end
end