require 'test_helper'

class Api::V1::CountriesControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @country = FactoryGirl.create(:country)
  end

  test "should create a country" do
    assert_difference('Country.count') do
      post :create, country: FactoryGirl.attributes_for(:country), format: 'json'
    end

    assert_response :created

    json = JSON.parse(@response.body)
    assert json['response']['country']['id'].present?
  end

  test "should search countries" do
    get :search, format: 'json'

    assert_response :success

    json = JSON.parse(@response.body)
    assert json['response'].present?
    assert_equal @country.name, json['response'].first['name']
    assert_equal @country.namespace, json['response'].first['namespace']
  end

end
