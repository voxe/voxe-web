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
          can [:read, :update], Election, ambassador_ids: user.id
          can :manage, ElectionTag, election: { ambassador_ids: user.id }
          can :manage, Candidacy, election: { ambassador_ids: user.id }
          can :manage, Candidate
          can :create, Proposition
          can :manage, Proposition, candidacy: { election: { ambassador_ids: user.id } }
          can :destroy, Comment, proposition: { candidacy: { election: { ambassador_ids: user.id } } }
        end
      end
    end
  end
end
