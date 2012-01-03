class Api::V1::UsersController < Api::V1::ApplicationController
  def search
    @users = User.where name: /#{params[:name]}/i
  end
end
