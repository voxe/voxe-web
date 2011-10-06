require 'test_helper'

class Api::V1::ThemesControllerTest < ActionController::TestCase
  setup do

  end

  test "should create a theme" do
    assert_difference('Theme.count') do
      post :create, theme: FactoryGirl.attributes_for(:theme)
    end

    assert_response :success
  end

end
