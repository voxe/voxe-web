require 'test_helper'

class Api::V1::ElectionsControllerTest < ActionController::TestCase
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

  test "should create an election" do
    assert_difference('Election.count') do
      post :create, election: FactoryGirl.attributes_for(:election)
    end

    json = JSON.parse @response.body
    assert_response :success
    assert json["election"]["_id"].present?
  end

  test "should show an election" do
    get :show, id: @election.to_param

    assert_response :success
    json = JSON.parse @response.body
    assert_equal @election.name, json['election']['name']

    assert_equal Array, json['election']['candidates'].class
    json['election']['candidates'].each do |json_candidate|
      assert json_candidate['id'].present?
      candidate = Candidate.find(json_candidate['id'])
      assert_equal candidate.firstName, json_candidate['firstName']
      assert_equal candidate.lastName, json_candidate['lastName']
    end

    assert_equal Array, json['election']['themes'].class
    json['election']['themes'].each do |json_theme|
      assert json_theme['id'].present?
      assert @election.themes.map{|t| t.id.to_s}.include?(json_theme['id'])
      theme = Theme.find(json_theme['id'])
      assert_equal theme.name, json_theme['name']
    end

  end

  test "should add a theme for an election" do
    @theme = FactoryGirl.create(:theme)
    post :addtheme, id: @election.to_param, themeId: @theme
    assert_response :success
    assert assigns(:election).themes.include?(@theme)
  end

  test "should add a candidate for an election" do
    @candidate = FactoryGirl.create(:candidate)
    post :addcandidate, id: @election.to_param, candidateId: @candidate
    assert_response :success
    assert assigns(:election).candidates.map{|c| c.id.to_s}.include?(@candidate.to_param)
  end

  test "should search some elections" do
    get :search
    # TODO Send params to search by year, country, current election, and parent election

    assert_response :success

    json = JSON.parse(@response.body)
    assert json['elections'].present?
  end
end
