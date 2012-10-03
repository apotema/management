class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.id.present?
      can :read, User, id: user.id
      can :manage, Entry, user_id: user.id
    end
    can :create, User
  end
end
