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

    json = JSON.parse @response.body
    assert_response :success
    assert json["election"]["id"].present?
  end

  test "should show an election" do
    get :show, id: @election.to_param

    assert_response :success
    json = JSON.parse @response.body
    assert_equal @election.name, json['election']['name']
    assert_equal Array, json['election']['candidates'].class
    assert_equal Array, json['election']['themes'].class
  end

  test "should add a theme for an election" do
    @theme = FactoryGirl.create(:theme)
    post :addtheme, id: @election.to_param, themeId: @theme
    assert_response :success
    assert assigns(:election).themes.include?(@theme)
  end

  test "should add a subtheme for an election" do
    @parent_theme = @election.themes.first
    @theme = FactoryGirl.create(:theme)
    post :addtheme, id: @election.to_param, themeId: @theme.to_param, parentThemeId: @parent_theme.to_param
    assert_response :success
    assert assigns(:election).sub_themes_of(@parent_theme.to_param).include?(@theme)
  end

  test "should add a candidate for an election" do
    @candidate = FactoryGirl.create(:candidate)
    post :addcandidate, id: @election.to_param, candidateId: @candidate
    assert_response :success
    assert assigns(:election).candidate_ids.include?(@candidate.to_param)
  end

  test "should search some elections" do
    get :search
    assert_response :success
    json = JSON.parse(@response.body)
    assert json['elections'].present?
    assert_equal ["id", "name"], json['elections'].first.keys
  end
end
