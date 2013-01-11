require 'test_helper'

class Api::V1::PropositionsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:admin)
    sign_in @user

    @election = FactoryGirl.create(:election)
    @parent_tag = Tag.first
    ElectionTag.create! election: @election, tag: @parent_tag
    @tag = Tag.last
    ElectionTag.create! election: @election, tag: @tag, parent_tag: @parent_tag
    @proposition = @election.candidacies.first.propositions.first
    @comment = @proposition.comments.create! text: "I agree because blabla ...", user: @user
  end

  test "should search some propositions" do
    assert_difference('Event.count', 1) do
      get :search, electionId: @election.to_param,
        tagIds: Tag.first.to_param,
        candidacyIds: @election.candidacies.collect(&:to_param).join(','),
        userDriven: "1",
        format: 'json'
    end

    assert_response :success
    json = JSON.parse(@response.body)
    assert_equal Array, json['response']['propositions'].class

    json['response']['propositions'].each do |proposition_attrs|
      assert proposition_attrs['id'].present?
      assert proposition_attrs['tags'].first['id'].present?
      assert proposition_attrs['candidacy']['id'].present?
      assert proposition_attrs['text'].present?
    end

    assert Event.last.user_driven
  end

  test "should search some propositions with limit" do
    get :search, electionId: @election.to_param,
      tagIds: Tag.first.to_param,
      candidacyIds: @election.candidacies.collect(&:to_param).join(','),
      limit: 1,
      format: 'json'

    assert_response :success
    json = JSON.parse(@response.body)

    assert_equal 1, json['response']['propositions'].size
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
    assert_difference "@proposition.reload.comments.count" do
      post :addcomment, id: @proposition.id.to_s, text: "I disagree because blablabla ...", format: 'json'
    end
    assert_response :success
  end

  test "should get the list of comments" do
    @proposition.comments.create user: @user, text: "Bla bla bla ... a lot !"
    get :comments, id: @proposition.id.to_s, format: 'json'
    assert_response :success
    json = JSON.parse(@response.body)
    assert json['response']['comments'].present?
    assert_equal Array, json['response']['comments'].class
    assert_equal @proposition.comments.count, json['response']['comments'].size
    assert json['response']['comments'].first['text'].present?
    assert json['response']['comments'].first['user']['id'].present?
  end

  test "should add an embed" do
    assert_difference('@proposition.reload.embeds.count') do
      post :addembed, id: @proposition.id.to_s, url: "http://www.youtube.com/watch?v=XGQewDiDN_E", format: 'json'
      # assert @proposition.
    end
    assert_response :success
    json = JSON.parse(@response.body)
    assert json['response']['proposition'].present?
  end

  test "should remove an embed" do
    embed = @proposition.embeds.create! url: "http://www.youtube.com/watch?v=XGQewDiDN_E"
    # assert_difference('@proposition.embeds.count') do
      delete :removeembed, id: @proposition.id.to_s, embedId: embed.id.to_s, format: 'json'
    # end
    assert_response :success
  end

  test "should remove a comment" do
    delete :removecomment, id: @proposition.id.to_s, commentId: @comment.id.to_s, format: 'json'
    assert_response :success
  end

  test "should trying to remove a comment" do
    sign_out @user
    sign_in FactoryGirl.create(:user)
    assert_no_difference "@proposition.comments.count" do
      delete :removecomment, id: @proposition.id.to_s, commentId: @comment.id.to_s, format: 'json'
    end
  end

  test "should remove own comment of user" do
    sign_out @user
    user = FactoryGirl.create(:user)
    sign_in user
    new_comment = @proposition.comments.create! text: "Blabla ...", user: user
    delete :removecomment, id: @proposition.id.to_s, commentId: new_comment.id.to_s, format: 'json'
    assert_response :success
  end

  test "should simply add a link as an embed" do
    title = 'Just a link'
    link = "http://www.twitter.com"
    assert_difference('@proposition.reload.embeds.count') do
      post :addembed, id: @proposition.id.to_s, url: link, title: title, format: 'json'
    end
    assert_response :success
    assert_equal 'link', assigns(:embed).type
    assert_equal title, assigns(:embed).title
    assert_equal link, assigns(:embed).url
  end
end
