require 'test_helper'

class Api::V1::PropositionsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

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
  end

  test "should search some propositions" do
    get :search, electionId: @election.to_param,
      themeIds: @election.themes.collect(&:to_param).join(','),
      candidateIds: @election.candidates.all.last(2).collect(&:to_param).join(',')

    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal Array, json['propositions'].class

    json['propositions'].each do |proposition_attrs|
      assert proposition_attrs['id'].present?
      assert @election.candidates.collect(&:to_param).include?(proposition_attrs['candidate']['id'])
      assert @election.sub_themes.collect(&:to_param).include?(proposition_attrs['theme']['id'])
      assert json['propositions'].first['text'].present?
    end
  end

  test "should create a proposition" do
    proposition_attributes                = {}
    proposition_attributes['text']        = "Something"
    proposition_attributes['electionId']  = @election.id
    proposition_attributes['themeId']     = @election.sub_themes.first
    proposition_attributes['candidateId'] = @election.candidates.last.id

    assert_difference('Proposition.count') do
      post :create, proposition: proposition_attributes
    end

    assert_response :success
  end

end
