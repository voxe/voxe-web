require 'test_helper'

class Api::V1::PropositionsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @election = FactoryGirl.create(:election)

    @theme = FactoryGirl.create(:theme)
    @category = FactoryGirl.create(:theme)
    @category.theme = @theme
    @category.save
    @section = FactoryGirl.create(:theme)
    @section.theme = @category
    @section.save

    @election.themes << @theme

    3.times do
      @election.candidates << FactoryGirl.create(:candidate)
      FactoryGirl.create(:proposition, :election => @election, :candidate => @election.candidates.last, :theme => @section)
      FactoryGirl.create(:proposition, :election => @election, :candidate => @election.candidates.last, :theme => @section)
      @election.candidates.last
    end

    @election.save!
  end

  test "should search some propositions" do
    get :search, electionId: @election.to_param,
      themeId: @theme.to_param,
      candidateIds: @election.candidates.collect(&:to_param).join(',')

    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal Array, json['propositions'].class

    json['propositions'].each do |proposition_attrs|
      assert proposition_attrs['id'].present?
      assert @election.candidates.collect(&:to_param).include?(proposition_attrs['candidateId'])
      assert_equal @election.to_param, Theme.find(proposition_attrs['sectionId']).theme.theme.election.to_param
      assert json['propositions'].first['text'].present?
    end
  end

  test "should create a proposition" do
    proposition_attributes                = {}
    proposition_attributes['text']        = "Something"
    proposition_attributes['electionId']  = @election.to_param
    proposition_attributes['themeId']     = @section.to_param
    proposition_attributes['candidateId'] = @election.candidates.last.to_param

    assert_difference('Proposition.count') do
      post :create, proposition: proposition_attributes
    end

    assert_response :success
  end

end
