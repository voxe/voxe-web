attributes :id, :text
node :tags do |proposition|
  proposition.tag_ids.collect do |tag_id|
    {id: tag_id}
  end
end
child :candidacy do
  attributes :id
end
node :comments do |proposition|
  {count: proposition.comments.count}
end
child embeds: :embeds do
  attributes :id, :title, :url, :provider_name, :type, :html
end

@object.class::USER_ACTIONS.each do |action|
  attribute @object.class.field_name_for_counter_cache(action)
  node "#{action}_users" do |proposition|
    {
      count: proposition.send(proposition.class.field_name_for_counter_cache(action)),
      data: partial('api/v1/propositions/user', object: proposition.send("#{action}_users"))
    }
  end
end
