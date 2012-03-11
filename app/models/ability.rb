class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :edit_password, User, :id => user.id
      can :update_password, User, :id => user.id
      can :update, User, :id => user.id
      can :show, User, :id => user.id
    end
  end
end
