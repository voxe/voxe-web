object false
child @user do
  attributes :id, :name, :email, :admin
  node :token do |user|
    user.authentication_token
  end
end
