require 'spec_helper'
require 'notification_handler'

describe NotificationHandler do
  subject { NotificationHandler.new }

  let(:order) { FactoryGirl.create(:order, :followed_payment_link => true) }
  let(:notification) { stub(:reference => order.id) }

  let!(:first) { FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first]) }
  let!(:during_payment) { FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) }
  let!(:after_payment) { FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) }

  it "should update trademark order status to first when status is cancelada" do
    notification.stub(:status => :cancelada)

    subject.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to first when status is devolvida" do
    notification.stub(:status => :devolvida)

    subject.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to during payment when status is em analise" do
    notification.stub(:status => :em_analise)
    
    subject.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to during payment when status is aguardando pagamento" do
    notification.stub(:status => :aguardando_pagamento)
    
    subject.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to after payment when status is paga" do
    notification.stub(:status => :paga)
    
    subject.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

  it "should update trademark order status to after payment when status is disponivel" do
    notification.stub(:status => :disponivel)
    
    subject.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

  it "should log when there is no handler for the specified notification" do
    notification.stub(:status => :not_existing)
    logger = stub
    Logger.stub(:new).with(STDERR).and_return(logger)
    logger.should_receive(:warn)

    subject.handle(notification)
  end

  it "should log when there is no order for the specified notification" do
    notification.stub(:reference => "30", :status => :disponivel)
    logger = stub
    Logger.stub(:new).with(STDERR).and_return(logger)
    logger.should_receive(:warn)

    subject.handle(notification)
  end

end
