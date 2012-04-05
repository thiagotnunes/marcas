require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:customer) { FactoryGirl.create(:customer) }
  let(:another_admin) { FactoryGirl.create(:admin) }
  let(:administrator_ability) { Ability.new(admin) }

  context "Users" do
    it "should be able to destroy a customer" do
      administrator_ability.should be_able_to(:destroy, customer)
    end

    it "should not be able to update another user" do
      administrator_ability.should_not be_able_to(:update, another_user)
    end

    it "should not be able to change another users password" do
      administrator_ability.should_not be_able_to(:change_password, another_user)
    end

    it "should not be able to destroy another admin" do
      administrator_ability.should_not be_able_to(:destroy, another_admin)
    end
  end

  context "Order statuses" do
    it "should be able to manage order statuses" do
      administrator_ability.should be_able_to(:manage, OrderStatus.new)
    end
  end

  context "Order types" do
    it "should be able to manage order types" do
      administrator_ability.should be_able_to(:manage, OrderType.new)
    end
  end

  context "Services" do
    it "should be able to manage services" do
      administrator_ability.should be_able_to(:manage, Service.new)
    end
  end

  context "Trademark orders" do 
    it "should be able to list trademark orders" do
      administrator_ability.should be_able_to(:list, TrademarkOrder.new)
    end

    it "should be able to show a trademark order" do
      administrator_ability.should be_able_to(:show, TrademarkOrder.new)
    end

    it "should be able to destroy a trademark order" do
      administrator_ability.should be_able_to(:destroy, TrademarkOrder.new)
    end

    it "should able to update the status of a trademark order" do
      administrator_ability.should be_able_to(:update_status, TrademarkOrder.new)
    end

    it "should not be able to create a new trademark order" do
      administrator_ability.should_not be_able_to(:create, TrademarkOrder.new)
    end

    it "should not be able to destroy a trademark order"
  end
end
