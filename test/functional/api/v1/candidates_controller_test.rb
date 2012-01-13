require 'test_helper'

class Api::V1::CandidatesControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @election = FactoryGirl.create(:election)

    @candidate = @election.candidacies.first.candidates.first
  end

  test "should create a candidate" do
    assert_difference('Candidate.count') do
      post :create, candidate: FactoryGirl.attributes_for(:candidate), format: 'json'
    end

    assert_response :success
  end

  test "should show a candidate" do
    get :show, id: @candidate.to_param, format: 'json'

    assert_response :success
    json = JSON.parse @response.body
    assert json['response']['candidate'].present?
    assert_equal @candidate.first_name, json['response']['candidate']['firstName']
    assert_equal @candidate.last_name, json['response']['candidate']['lastName']
  end

  test "should post a photo on a candidate" do
    post :addphoto, id: @candidate.to_param,
      type: 'square',
      image: fixture_file_upload(File.join(Rails.root, '/app/assets/images/rails.png'), 'image/png'),
      format: 'json'

    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal @candidate.reload.photos.last.image.url, json['response']['photo']['image']['url']
    assert assigns(:candidate).photos.any?
    @candidate.reload.photos.map {|i| i.remove_image! }
  end

  test "should fail when posting an empty on a candidate" do
    post :addphoto, id: @candidate.to_param,
      type: 'square',
      image: "",
      format: 'json'
    assert_response :unprocessable_entity
    json = JSON.parse(@response.body)
    assert_equal 422, json['meta']['code']
  end

  test "should search for candidates" do
    get :search, name: 'Nico', format: 'json'
    assert_response :success
  end
end
