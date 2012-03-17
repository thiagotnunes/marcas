require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:admin) { Factory(:admin) }
  let(:customer) { Factory(:customer) }
  let(:another_user) { Factory(:user) }

  context "Administrator" do
    let(:another_admin) { Factory(:admin) }
    let(:administrator_ability) { Ability.new(admin) }

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

    it "should be able to manage order statuses" do
      administrator_ability.should be_able_to(:manage, OrderStatus.new)
    end
  end

  context "Customer" do
    let(:customer_ability) { Ability.new(customer) }

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

    it "should not be able to manage order statuses" do
      customer_ability.should_not be_able_to(:manage, OrderStatus.new) 
    end
  end

  context "Guest" do
    let(:guest_ability) { Ability.new(nil) }

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

    it "should not be able to manage order statuses" do
      guest_ability.should_not be_able_to(:manage, OrderStatus.new) 
    end
  end
  
end
