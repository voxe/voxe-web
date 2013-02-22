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
node :supporters do |proposition|
  {count: proposition.support_users.count}
  {count: proposition.support_users.count, data: partial('api/v1/propositions/user', object: proposition.support_users)}
end
node :against_users do |proposition|
  {count: proposition.against_users.count, data: partial('api/v1/propositions/user', object: proposition.against_users)}
end
node :favorite_users do |proposition|
  {count: proposition.favorite_users.count, data: partial('api/v1/propositions/user', object: proposition.favorite_users)}
end
