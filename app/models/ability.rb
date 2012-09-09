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

    # If user is logged in
    if user.persisted?
      # Visitor

      can :addcomment, Proposition
      can :removecomment, Proposition # Access to the controller action "removecomment"
      can :destroy, Comment, user_id: user.id # Instance access to method destroy

      if user.admin?
        can :manage, :all
      else
        if user.ambassador_elections.exists?
          can :index, :dashboard
          can :search, User
          can :manage, Tag
          can :manage, Election, ambassador_ids: user.id
          can :manage, Candidacy, election: { ambassador_ids: user.id }
          can :create, Candidate
          can :manage, Candidate, candidacies: { election: { ambassador_ids: user.id } }
          can :create, Proposition
          can :manage, Proposition, candidacy: { election: { ambassador_ids: user.id } }
          can :destroy, Comment, proposition: { candidacy: { election: { ambassador_ids: user.id } } }
        end
        if user.contributor_elections.exists?
          can :index, :dashboard
          can [:ambassadors, :contributors], Election, contributor_ids: user.id
          can :create, Proposition
          can :manage, Proposition, candidacy: { election: { contributor_ids: user.id } }
          can :destroy, Comment, proposition: { candidacy: { election: { contributor_ids: user.id } } }
        end
      end
    end
    
    # public
    can [:read, :search], Election
    can [:read, :search, :elections], Candidate
    can [:read, :search, :comments], Proposition
    can [:read, :propositions, :search], Tag
    can :read, Candidacy
    can [:create, :verify, :self, :facebookconnect], User
  end
end
