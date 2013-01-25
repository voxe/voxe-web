object false
child @proposition do
  attributes :id, :text
  child :tags do
    attributes :id
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
  end
  node :against_users do |proposition|
    {count: proposition.against_users.count}
  end
  node :favorite_users do |proposition|
    {count: proposition.favorite_users.count}
  end
end
