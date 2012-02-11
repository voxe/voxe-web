object false
child @user do
  extends "api/v1/users/base"
  attributes :email, :admin
  node :token do |user|
    user.authentication_token
  end
end
