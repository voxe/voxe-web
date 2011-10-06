require 'test_helper'

class Api::V1::CandidatesControllerTest < ActionController::TestCase
  setup do
    
  end

  test "should create a candidate" do
    assert_difference('Candidate.count') do
      post :create, candidate: FactoryGirl.attributes_for(:candidate)
    end

    assert_response :success
  end
end
