require 'test_helper'

class Api::V1::CandidatesControllerTest < ActionController::TestCase
  setup do
    @election = FactoryGirl.create(:election)

    @election.theme_ids[FactoryGirl.create(:theme).to_param] = [
      FactoryGirl.create(:theme).to_param,
      FactoryGirl.create(:theme).to_param
    ]

    3.times do
      @election.candidates << FactoryGirl.create(:candidate)
      FactoryGirl.create(:proposition, :election => @election, :candidate => @election.candidates.last, :theme => Theme.find(@election.theme_ids.first).first)
      FactoryGirl.create(:proposition, :election => @election, :candidate => @election.candidates.last, :theme => Theme.find(@election.theme_ids.first).last)
      @election.candidates.last
    end

    @election.save
    @candidate = @election.candidates.first
  end

  test "should create a candidate" do
    assert_difference('Candidate.count') do
      post :create, candidate: FactoryGirl.attributes_for(:candidate)
    end

    assert_response :success
  end

  test "should show a candidate" do
    get :show, id: @candidate.to_param

    assert_response :success
    json = JSON.parse @response.body
    assert json['candidate'].present?
    assert_equal @candidate.firstName, json['candidate']['firstName']
    assert_equal @candidate.lastName, json['candidate']['lastName']
  end

  test "should show elections of a candidate" do
    get :elections, id: @candidate.to_param

    assert_response :success
    json = JSON.parse @response.body
    assert json['elections'].present?
    assert_equal @election.name, json['elections'].first['name']
  end

  test "should post a photo on a candidate" do
    post :addphoto, id: @candidate.to_param,
      type: 'square',
      image: fixture_file_upload(File.join(Rails.root, '/app/assets/images/rails.png'), 'image/png')

    assert_response :success
    json = JSON.parse(@response.body)
    assert @candidate.reload.photos.last.image.url, json['photo']['url']
    assert assigns(:candidate).photos.any?
    @candidate.reload.photos.map {|i| i.remove_image! }
  end
end
