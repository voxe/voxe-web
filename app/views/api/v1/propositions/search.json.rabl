object false
child @propositions do
  attributes :id, :text
  node :tags do |propositions|
    propositions.tag_ids.collect do |tag_id|
      {id: tag_id}
    end
  end
  child :candidacy do
    attributes :id
  end
end