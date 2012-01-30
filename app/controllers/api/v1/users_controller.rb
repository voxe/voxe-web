class Api::V1::UsersController < Api::V1::ApplicationController
  def search
    @users = User.where name: /#{params[:name]}/i
  end

  def create
    if @user.save
      render 'api/v1/users/show.rabl', status: :created
    else
      render text: {errors: @user.errors}.to_json, status: :unprocessable_entity, layout: 'api_v1'
    end
  end
end
