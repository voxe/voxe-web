attributes :id, :text
child :user do
  extends "api/v1/users/base"
end