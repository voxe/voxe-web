require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  setup do
    @contributor = FactoryGirl.create(:user)

    @election = FactoryGirl.create(:election)
    @election.contributors << @contributor
    @election.save!

    @unauthorize_election = FactoryGirl.create(:election)
  end

  test "a contributor should only edit elections where he is affected to" do
    ability = Ability.new(@contributor)
    assert ability.can?(:update, @election)
    assert ability.can?(:create, Proposition.new(candidacy: @election.candidacies.first))
    assert ability.can?(:update, @election.candidacies.first)
  end

  test "a contributor should not edit an election where he's not assigned to" do
    ability = Ability.new(@contributor)
    assert ability.cannot?(:update, @unauthorize_election)
    assert ability.cannot?(:create, Proposition.new(candidacy: @unauthorize_election.candidacies.first))
    assert ability.cannot?(:update, @unauthorize_election.candidacies.first)
  end

end
