require 'test_helper'

class Api::V1::PropositionsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @election = FactoryGirl.create(:election)
  end

  test "should search some propositions" do
    get :search, electionId: @election.to_param,
      tagIds: Tag.first.to_param,
      candidacyIds: @election.candidacies.collect(&:to_param).join(','),
      format: 'json'

    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal Array, json['response']['propositions'].class

    json['response']['propositions'].each do |proposition_attrs|
      assert proposition_attrs['id'].present?
      assert proposition_attrs['tags'].first['id'].present?
      assert proposition_attrs['candidacy']['id'].present?
      assert proposition_attrs['text'].present?
    end
  end

  test "should create a proposition" do
    proposition_attributes                = {}
    proposition_attributes['text']        = "Something"
    proposition_attributes['tagNames']      = [Tag.first.name, Tag.last.name]
    proposition_attributes['candidacyId'] = @election.candidacies.last.to_param

    assert_difference('Proposition.count') do
      post :create, proposition: proposition_attributes, format: 'json'
    end
    assert_response :success
  end

end
