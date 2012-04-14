require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:customer) { FactoryGirl.create(:customer) }
  let(:another_user) { FactoryGirl.create(:user) }
  let(:customer_ability) { Ability.new(customer) }

  context "Users" do
    it "should be able to update its own password" do
      customer_ability.should be_able_to(:edit_password, customer)
      customer_ability.should be_able_to(:update_password, customer)
    end

    it "should be able to update itself" do
      customer_ability.should be_able_to(:edit, customer) 
      customer_ability.should be_able_to(:update, customer) 
    end

    it "should be able to show itself" do
      customer_ability.should be_able_to(:show, customer) 
    end

    it "should not be able to create users" do
      customer_ability.should_not be_able_to(:create, User.new)
    end

    it "should not be able to change another users password" do
      customer_ability.should_not be_able_to(:change_password, another_user)
    end

    it "should not be able to update another user" do
      customer_ability.should_not be_able_to(:edit, another_user)
      customer_ability.should_not be_able_to(:update, another_user)
    end

    it "should not be able to show another user" do
      customer_ability.should_not be_able_to(:show, another_user)
    end

    it "should not be able to list users" do
      customer_ability.should_not be_able_to(:list, User.new)
    end

    it "should not be able to destroy itself" do
      customer_ability.should_not be_able_to(:destroy, customer)
    end

    it "should not be able to destroy another user" do
      customer_ability.should_not be_able_to(:destroy, another_user)
    end
  end

  context "Order statuses" do
    it "should not be able to manage order statuses" do
      customer_ability.should_not be_able_to(:manage, OrderStatus.new) 
    end
  end

  context "Order types" do
    it "should not be able to manager order types" do
      customer_ability.should_not be_able_to(:manage, OrderType.new)
    end
  end

  context "Services" do
    it "should not be able to manage services" do
      customer_ability.should_not be_able_to(:manage, Service.new)
    end
  end

  context "Trademark orders" do 
    it "should be able to create a new trademark order" do
      customer_ability.should be_able_to(:create, TrademarkOrder.new)
    end

    it "should be able to list the trademark orders" do
      customer_ability.should be_able_to(:index, TrademarkOrder.new)
    end

    it "should be able to show trademark orders" do
      trade = TrademarkOrder.new
      trade.purchase = Order.new
      trade.purchase.user = customer
      customer_ability.should be_able_to(:show, trade)
    end

    it "should not be able to destroy a trademark order" do
      customer_ability.should_not be_able_to(:destroy, TrademarkOrder.new)
    end

    it "should not be able to list trademark orders" do
      customer_ability.should_not be_able_to(:list, TrademarkOrder.new)
    end

    it "should not be able to update status of a trademark order" do
      customer_ability.should_not be_able_to(:update_status, TrademarkOrder.new)
    end
  end

  context "Orders" do
    it "should be able to checkout it's own order" do
      order = Order.new
      order.user = customer
      customer_ability.should be_able_to(:checkout, order)
    end

    it "should not be able to checkout another user's order" do
      order = Order.new
      order.user = another_user
      customer_ability.should_not be_able_to(:checkout, order)
    end

    it "should be able to pay for it's own order" do
      order = Order.new
      order.user = customer
      customer_ability.should be_able_to(:pay, order)
    end

    it "should not be able to pay for another user's order" do
      order = Order.new
      order.user = another_user
      customer_ability.should_not be_able_to(:pay, order)
    end

    it "should not be able to pay for an order when the user has already followed the payment link" do
      order = Order.new
      order.user = customer
      order.followed_payment_link = true
      customer_ability.should_not be_able_to(:pay, order)
    end
  end

end
