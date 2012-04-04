require 'spec_helper'
require 'notification_handler'

describe NotificationHandler do

  let(:notification) { stub(:notification) }
  let(:order) { order = FactoryGirl.create(:trademark_order) }

  before :each do
    notification.stub(:products => [{:id => order.id}])
  end

  it "should update trademark order status to after payment when status is verifying" do
    after_payment = FactoryGirl.create(:order_status, :after_payment => 1) 
    notification.stub(:status => :verifying)
    
    NotificationHandler.handle(notification)

    TrademarkOrder.find(order.id).order_status.should == after_payment
  end

  it "should update trademark order status to after payment when status is pending" do
    after_payment = FactoryGirl.create(:order_status, :after_payment => 1) 
    notification.stub(:status => :pending)
    
    NotificationHandler.handle(notification)

    TrademarkOrder.find(order.id).order_status.should == after_payment
  end

  it "should update trademark order status to first when status is canceled" do
    first = FactoryGirl.create(:order_status, :first_status => 1)
    notification.stub(:status => :canceled)

    NotificationHandler.handle(notification)

    TrademarkOrder.find(order.id).order_status.should == first
  end

  it "should update trademark order status to first when status is refunded" do
    first = FactoryGirl.create(:order_status, :first_status => 1)
    notification.stub(:status => :refunded)

    NotificationHandler.handle(notification)

    TrademarkOrder.find(order.id).order_status.should == first
  end
end
