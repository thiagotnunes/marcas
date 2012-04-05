require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:guest_ability) { Ability.new(nil) }

  context "Users" do
    it "should not be able to change password" do
      guest_ability.should_not be_able_to(:change_password, User.new)      
    end

    it "should not be able to update an user" do
      guest_ability.should_not be_able_to(:update, User.new)      
    end

    it "should not be able to read users" do
      guest_ability.should_not be_able_to(:read, User.new)      
    end

    it "should not be able to destroy users" do
      guest_ability.should_not be_able_to(:destroy, User.new)      
    end
  end

  context "Order statuses" do
    it "should not be able to manage order statuses" do
      guest_ability.should_not be_able_to(:manage, OrderStatus.new) 
    end
  end

  context "Order types" do
    it "should not be able to manage order types" do
      guest_ability.should_not be_able_to(:manage, OrderType.new)
    end
  end

  context "Services" do
    it "should not be able to manage services" do
      guest_ability.should_not be_able_to(:manage, Service.new)
    end
  end

  context "Trademark orders" do
    it "should not be able to manage trademark orders" do
      guest_ability.should_not be_able_to(:manage, TrademarkOrder.new)
    end
  end
end
