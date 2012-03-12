class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :update, User do |other|
        user.id != other.id
      end
      cannot :edit_password, User do |other|
        user.id != other.id
      end
      cannot :update_password, User do |other|
        user.id != other.id
      end
      cannot :destroy, User do |other|
        other.admin?
      end
    else
      can :edit_password, User, :id => user.id
      can :update_password, User, :id => user.id
      can :update, User, :id => user.id
      can :show, User, :id => user.id
    end
  end
end
