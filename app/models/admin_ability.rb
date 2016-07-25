class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # If user is logged in
    if user.persisted?
      if user.admin?
        can :manage, :all
      else
        if user.ambassador_elections.exists?
          can :index, :dashboard
          can :search, User
          can [:read], Election, ambassador_ids: user.id
          can :manage, ElectionTag, election: { ambassador_ids: user.id }
          can :manage, Candidacy, election: { ambassador_ids: user.id }
          can :manage, Candidate
          can :manage, CandidacyCandidateProfile, election: { ambassador_ids: user.id }
          can :manage, :contributor
          can :create, Proposition
          can :manage, Proposition, candidacy: { election: { ambassador_ids: user.id } }
          can :destroy, Comment, proposition: { candidacy: { election: { ambassador_ids: user.id } } }
        end
        if user.contributor_elections.exists?
          can :index, :dashboard
          can :search, User
          can [:read], Election, contributor_ids: user.id
          can :manage, ElectionTag, election: { contributor_ids: user.id }
          can :read, Candidacy, election: { contributor_ids: user.id }
          can :create, Proposition
          can :manage, Proposition, candidacy: { election: { contributor_ids: user.id } }
          can :destroy, Comment, proposition: { candidacy: { election: { contributor_ids: user.id } } }
        end
      end
    end
  end
end
