class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :edit_password, :update_password, :to => :change_password

    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :update, User do |other|
        user.id != other.id
      end
      cannot :change_password, User do |other|
        user.id != other.id
      end
      cannot :destroy, User do |other|
        other.admin?
      end
    elsif user.customer?
      can :change_password, User, :id => user.id
      can :update, User, :id => user.id
      can :show, User, :id => user.id
    end
  end
end
