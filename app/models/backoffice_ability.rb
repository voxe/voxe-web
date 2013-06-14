class BackofficeAbility
  include CanCan::Ability

  def initialize(current_user)
    can :manage, Candidacy do |candidacy|
      candidacy.user == current_user
    end

    can :manage, Proposition do |proposition|
      proposition.candidacy == current_candidacy
    end

    can :read, Election

    can :manage, CandidacyCandidateProfile do |profile|
      profile.candidacy == current_candidacy
    end

  end
end
