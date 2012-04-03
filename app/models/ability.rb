class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :edit_password, :update_password, :to => :change_password

    user ||= User.new
    if user.admin?
      admin_abilities_for(user)
    elsif user.customer?
      customer_abilities_for(user)
    end
  end

  def admin_abilities_for(user)
    can :manage, :all

    cannot [:change_password, :update], User do |other|
      user.id != other.id
    end
    cannot :destroy, User do |other|
      other.admin?
    end

    cannot [:create], TrademarkOrder
  end

  def customer_abilities_for(user)
    can [:change_password, :update, :show], User, :id => user.id
    can [:create], TrademarkOrder
    can [:show, :pay], TrademarkOrder, :user_id => user.id
  end
end
