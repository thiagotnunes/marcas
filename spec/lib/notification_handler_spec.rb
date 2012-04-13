require 'spec_helper'
require 'notification_handler'

describe NotificationHandler do

  let(:notification) { stub(:notification) }
  let(:order) { FactoryGirl.create(:order, :followed_payment_link => true) }

  before :each do
    notification.stub(:products => [{:id => order.id}])
  end

  it "should update trademark order status to first when status is canceled" do
    first = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
    notification.stub(:status => :canceled)

    NotificationHandler.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to first when status is refunded" do
    first = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
    notification.stub(:status => :refunded)

    NotificationHandler.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to during payment when status is verifying" do
    during_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) 
    notification.stub(:status => :verifying)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to during payment when status is pending" do
    during_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) 
    notification.stub(:status => :pending)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to after payment when status is completed" do
    after_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) 
    notification.stub(:status => :completed)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

  it "should update trademark order status to after payment when status is approved" do
    after_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) 
    notification.stub(:status => :approved)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

end
