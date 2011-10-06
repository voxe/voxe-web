require 'test_helper'

class Api::V1::ElectionsControllerTest < ActionController::TestCase
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
  end

  test "should create an election" do
    assert_difference('Election.count') do
      post :create, election: FactoryGirl.attributes_for(:election)
    end

    assert_response :success
  end

  test "should show an election" do
    get :show, id: @election.to_param

    assert_response :success
    json = JSON.parse @response.body
    assert_equal @election.name, json['name']
  end

  test "should compare an election" do
    @theme = Theme.find(@election.theme_ids.first)
    post :compare, id: @election.to_param, themeId: @theme.to_param, :candidateIds => "#{Candidate.first.to_param},#{Candidate.first.to_param}"

    assert_response :success
    json = JSON.parse @response.body

    assert_equal @election.candidates.size, json['candidates'].size
    assert json['candidates']['name'].present?

    @sub_themes = @election.sub_themes(@theme.id)

    assert_equal @theme.name, json['theme']['name']
    assert_equal @sub_themes.size, json['theme']['themes'].size
    assert json['theme']['themes'].first['candidates'].present?
    assert json['theme']['themes'].first['candidates']['propositions'].present?
  end

  test "should add a theme for an election" do
    @theme = FactoryGirl.create(:theme)
    post :addtheme, id: @election.to_param, themeId: @theme
    assert_response :success
    assert assigns(:election).theme_ids.keys.include?(@theme.to_param)
  end

  test "should add a candidate for an election" do
    @candidate = FactoryGirl.create(:candidate)
    post :addcandidate, id: @election.to_param, candidateId: @candidate
    assert_response :success
    assert assigns(:election).candidate_ids.include?(@candidate.to_param)
  end
end
