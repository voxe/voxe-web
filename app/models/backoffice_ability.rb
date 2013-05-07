class BackofficeAbility
  include CanCan::Ability

  def initialize(current_user)
    can :manage, Candidate do |candidate|
      candidate.user == current_user
    end
  end
end