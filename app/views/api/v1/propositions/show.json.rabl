object false
child @proposition do
  extends 'api/v1/propositions/base'
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
