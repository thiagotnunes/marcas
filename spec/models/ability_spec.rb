require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:customer) { FactoryGirl.create(:customer) }
  let(:another_user) { FactoryGirl.create(:user) }

  context "Administrator" do
    let(:another_admin) { FactoryGirl.create(:admin) }
    let(:administrator_ability) { Ability.new(admin) }

    context "Users" do
      it "should not be able to update another user" do
        administrator_ability.should_not be_able_to(:update, another_user)
      end

      it "should not be able to change another users password" do
        administrator_ability.should_not be_able_to(:change_password, another_user)
      end

      it "should not be able to destroy another admin" do
        administrator_ability.should_not be_able_to(:destroy, another_admin)
      end

      it "should be able to destroy a customer" do
        administrator_ability.should be_able_to(:destroy, customer)
      end
    end

    context "Order statuses" do
      it "should be able to manage order statuses" do
        administrator_ability.should be_able_to(:manage, OrderStatus.new)
      end
    end

    context "Order types" do
      it "should be able to manager order types" do
        administrator_ability.should be_able_to(:manage, OrderType.new)
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
      
      it "should not be able to update a trademark order" do
        administrator_ability.should be_able_to(:update, TrademarkOrder.new)
      end

      it "should not be able to create a new trademark order" do
        administrator_ability.should_not be_able_to(:create, TrademarkOrder.new)
      end
    end
  end

  context "Customer" do
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

      it "should not be able to read users" do
        customer_ability.should_not be_able_to(:index, User.new)
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

    context "Trademark orders" do 
      it "should be able to create a new trademark order" do
        customer_ability.should be_able_to(:create, TrademarkOrder.new)
      end

      it "should be able to list the trademark orders" do
        customer_ability.should be_able_to(:index, TrademarkOrder.new)
      end

      it "should be able to show trademark orders" do
        order = TrademarkOrder.new
        order.user_id = customer.id
        customer_ability.should be_able_to(:show, order)
      end

      it "should be able to pay for it's own trademark order" do
        order = TrademarkOrder.new
        order.user_id = customer.id
        customer_ability.should be_able_to(:pay, order)
      end

      it "should not be able to destroy a trademark order" do
        customer_ability.should_not be_able_to(:destroy, TrademarkOrder.new)
      end

      it "should not be able to list trademark orders" do
        customer_ability.should_not be_able_to(:list, TrademarkOrder.new)
      end

      it "should not be able to update a trademark order" do
        customer_ability.should_not be_able_to(:update, TrademarkOrder.new)
      end
    end
  end

  context "Guest" do
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
      it "should not be able to manager order types" do
        guest_ability.should_not be_able_to(:manage, OrderType.new)
      end
    end

    context "Trademark orders" do
      it "should not be able to manage trademark orders" do
        guest_ability.should_not be_able_to(:manage, TrademarkOrder.new)
      end
    end
  end
  
end
