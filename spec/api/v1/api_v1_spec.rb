require 'spec_helper'

describe '/api/v1' do
  let(:api_base_url) { 'http://voxe.org/api/v1' }

  describe '/propositions' do
    describe '/propositions/:id/favorite' do
      let!(:user) { FactoryGirl.create :user }
      let!(:proposition) { FactoryGirl.create :proposition_with_tags }

      subject { last_response }

      describe 'POST - set as favorite' do
        let!(:request) { post "#{api_base_url}/propositions/#{proposition.to_param}/favorite", auth_token: user.authentication_token }

        it 'should create a the UserAction::Favorite in database' do
          UserAction::Favorite.count.should eq 1
        end
        it 'should be idempotent' do
          post "#{api_base_url}/propositions/#{proposition.to_param}/favorite", auth_token: user.authentication_token
          UserAction::Favorite.count.should eq 1
        end
        describe 'response' do
          its(:status) { should eq 201 }
        end
      end

      describe 'DELETE - remove from favorites' do
        let!(:user_action) { FactoryGirl.create :favorite_user_action, user: user, proposition: proposition }
        let!(:request) { delete "#{api_base_url}/propositions/#{proposition.to_param}/favorite", auth_token: user.authentication_token }
        it 'should remove the UserAction::Favorite form database' do
          UserAction::Favorite.count.should eq 0
        end
        describe 'response' do
          its(:status) { should eq 204 }
        end
      end
    end
  end
end
