require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @user = User.first
  end

  test "should search users" do
    get :search, name: @user.name, format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)

    assert_equal Array, json['response'].class
    json['response'].each do |json_user|
      reg = /#{@user.name}/i
      assert reg.match(json_user['name'])
    end
  end

  test "should create an user" do
    assert_difference 'User.count' do
      post :create, user: FactoryGirl.attributes_for(:user), format: 'json'
    end
    assert_response :created
  end
end
