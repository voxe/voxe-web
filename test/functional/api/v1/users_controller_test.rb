require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  setup do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin

    @user = User.first

    FactoryGirl.create(:election)
    Proposition.last.comments.create user: @user, text: "blabla"    
    Proposition.first.comments.create user: FactoryGirl.create(:user), text: "Yet another comment from another user"
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

  test "should sign in and success" do
    get :verify, email: @user.email, password: 'password', format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal @user.authentication_token, json['response']['user']['token']
  end

  test "should try to sign in and failed" do
    get :verify, email: @user.email, password: 'wrong-password', format: 'json'
    assert_response :unprocessable_entity
    json = JSON.parse(@response.body)
    assert json['response']['errors']['user'].present?
  end

  test "should get the current user" do
    get :self, format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal @user.authentication_token, json['response']['user']['token']
  end

  test "should use Facebook connect and fail" do
    post :facebookconnect, facebookToken: 'somethingthatdoesnotwork', format: 'json'
    assert_response :unprocessable_entity
    json = JSON.parse(@response.body)
    assert json['response']['errors'].present?
  end

  test "shoudl use Facebook connect" do
    # TODO Don't know how to test this without a real token. Is there any sandbox on Facebook ? Or maybe Koala can mock an user ?

    # assert_difference('User.count') do
    #   post :facebookconnect, facebookToken: 'COPY-HERE-A-REAL-TOKEN', format: 'json'
    # end
    # assert_response :success
    # json = JSON.parse(@response.body)
    # assert json['response']['user'].present?
    # assert json['response']['user']['token'].present?
  end

  test "should destroy an user with his comments" do
    @user.proposition_comments.each do |comment|
      assert_equal @user.id, comment.user_id
    end

    assert_difference('User.count', -1) do
      delete :destroy, id: @user.id.to_s
    end
    assert_response :success

    Proposition.all.each do |proposition|
      proposition.comments.each do |comment|
        assert_not_equal comment.user_id, @user.id
      end
    end
  end

  test "should add admin role to an user" do
    put :addadmin, id: @user.id.to_s, format: 'json'
    assert_response :success
    @user.reload
    assert @user.admin
  end

  test "should remove admin role to an user" do
    put :removeadmin, id: @admin.id.to_s, format: 'json'
    assert_response :success
    @admin.reload
    assert !@user.admin
  end

  test "should get a list of all admins" do
    get :admins, format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    json['response'].each do |user|
      assert user['admin']
    end
  end
end
