require 'test_helper'

class Api::V1::OrganizationsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)
  end

  test "should create an organization" do
    post :create, organization: {name: "Union pour les developpeurs"}, format: 'json'
    assert_response :success
  end

end
