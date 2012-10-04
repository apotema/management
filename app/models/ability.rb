class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.id.present?
      can :read, User, id: user.id
      can :manage, Entry, user_id: user.id
    end
    can :create, User
  end
end
