class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new

    # If usser is logged in
    if user.persisted?
      if user.admin?
        can :manage, :all
      else
        can :manage, Election, contributor_ids: user.id
        can :manage, Candidacy, election: { contributor_ids: user.id }
        can :manage, Candidate, candidacy: { election: { contributor_ids: user.id } }
        can :manage, Proposition, candidacy: { election: { contributor_ids: user.id } }
        can :manage, Tag
      end
    else
      # Visitor

      can [:read, :search], Election
      can [:read, :elections], Candidate
      can :search, Proposition
      can [:read, :propositions, :search], Tag
      can :read, Candidacy
      can :search, User
    end

  end
end