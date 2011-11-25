require 'test_helper'

class Api::V1::ThemesControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @theme = FactoryGirl.create(:theme)
  end

  test "should create a theme" do
    assert_difference('Theme.count') do
      post :create, theme: FactoryGirl.attributes_for(:theme)
    end

    assert_response :success
  end

  test "should create a sub theme" do
    assert_difference('Theme.count') do
      post :create, theme: FactoryGirl.attributes_for(:theme).merge({parentThemeId: @theme.to_param})
    end

    assert_equal @theme.id, assigns(:theme).theme.id
    assert_response :success
  end

  test "should get all themes" do
    get :index

    assert_response :success
    json = JSON.parse(@response.body)
    assert json['themes'].present?
    assert json['themes'].first['id'].present?
    assert json['themes'].first['name'].present?
  end

  test "should post a photo on a theme" do
    post :addphoto, id: @theme.to_param,
      type: 'square',
      image: fixture_file_upload(File.join(Rails.root, '/app/assets/images/rails.png'), 'image/png')

    assert_response :success
    assert assigns(:theme).photos.any?
    @theme.reload.photos.map {|i| i.remove_image!}
  end

end
