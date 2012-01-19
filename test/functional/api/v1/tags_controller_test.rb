require 'test_helper'

class Api::V1::TagsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @tag = FactoryGirl.create(:tag)
  end

  test "should create a tag" do
    assert_difference('Tag.count') do
      post :create, tag: FactoryGirl.attributes_for(:tag), format: 'json'
    end

    assert_response :created

    json = JSON.parse(@response.body)
    assert json['response']['tag']['id'].present?
  end

  test "should search tags" do
    get :search, :name => @tag.name, format: 'json'

    assert_response :success

    json = JSON.parse(@response.body)
    json['response'].each do |tag|
      reg = /#{@tag.name}/i
      assert reg.match(tag['name'])
    end
  end

  test "should show a tag" do
    get :show, id: @tag.to_param, format: 'json'

    assert_response :success

    json = JSON.parse(@response.body)
    assert_equal @tag.name, json['response']['tag']['name']
    assert_equal @tag.namespace, json['response']['tag']['namespace']
  end

  test "should update a tag" do
    new_name = "New name of tag"
    put :update, id: @tag.id.to_s, tag: {name: new_name}, format: 'json'

    assert_response :success
    assert_equal new_name, assigns(:tag).name
  end

end
