require 'test_helper'

class Api::V1::PropositionsControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:admin)

    @election = FactoryGirl.create(:election)
    @parent_tag = Tag.first
    ElectionTag.create! election: @election, tag: @parent_tag
    @tag = Tag.last
    ElectionTag.create! election: @election, tag: @tag, parent_tag: @parent_tag
    @proposition = @election.candidacies.first.propositions.first
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
    proposition_attributes['tagIds']      = @tag
    proposition_attributes['candidacyId'] = @election.candidacies.last.to_param

    assert_difference('Proposition.count') do
      post :create, proposition: proposition_attributes, format: 'json'
    end
    assert_response :success

    assert assigns(:proposition).tags.size > 1
  end

  test "should update text and tags of a proposition" do
    new_tag_id = @parent_tag.id.to_s
    new_text = "Here we are: a new proposition !"
    assert_no_difference('Proposition.count') do
      put :update, id: @proposition.id.to_s, format: 'json', proposition: {
        tagIds: new_tag_id,
        text: new_text
      }
    end

    assert_response :success
    assert_equal 1, assigns(:proposition).tags.count
    assert_equal new_tag_id, assigns(:proposition).tags.first.id.to_s
    assert_equal new_text, assigns(:proposition).text
  end

  test "should delete a proposition" do
    assert_difference('Proposition.count', -1) do
      delete :destroy, id: @proposition.id.to_s
    end
    assert_response :success
  end

  test "should post a comment on proposition" do
    assert_difference "@proposition.comments.count" do
      post :addcomment, id: @proposition.id.to_s, comment: {text: "I disagree because blablabla ..."}, format: 'json'
    end
    assert_response :success
  end

  test "should get the list of comments" do
    @proposition.comments.create user: User.first, text: "Bla bla bla ... a lot !"
    get :comments, id: @proposition.id.to_s, format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal Array, json['response'].class
    assert_equal 1, json['response'].size
    assert json['response'].first['text'].present?
    assert json['response'].first['user']['id'].present?
  end
end
