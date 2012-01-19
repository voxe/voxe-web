require 'test_helper'

class Api::V1::CandidaciesControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @election = FactoryGirl.create(:election)
    @candidacy = @election.candidacies.first
  end

  test "should show a candidacy" do
    get :show, id: @candidacy.to_param, format: 'json'

    assert_response :success
    json = JSON.parse(@response.body)

    assert_equal @candidacy.to_param, json['response']['candidacy']['id']
    assert_equal @candidacy.published, json['response']['candidacy']['published']
    assert_equal @candidacy.candidates.first.to_param, json['response']['candidacy']['candidates'].first['id']
    assert_equal @candidacy.election.id.to_s, json['response']['candidacy']['election']['id']
  end

  test "should update a candidacy to published true" do
    assert_equal false, @candidacy.published
    put :update,
      id: @candidacy.to_param,
      candidacy: {
        published: true
      },
      format: 'json'

    assert_response :success
    json = JSON.parse(@response.body)

    assert_equal true, json['response']['candidacy']['published']
  end

  test "should bind an organization to this candidacy" do
    organization = FactoryGirl.create(:organization)

    post :addorganization, id: @candidacy.id.to_s, organizationId: organization.id.to_s, format: 'json'

    assert_equal organization, assigns(:candidacy).organization
  end
end
