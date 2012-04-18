require 'spec_helper'
require 'notification_handler'

describe NotificationHandler do

  let(:notification) { stub(:notification) }
  let(:order) { FactoryGirl.create(:order, :followed_payment_link => true) }

  before :each do
    notification.stub(:products => [{:id => order.id}])
  end

  it "should update trademark order status to first when status is cancelada" do
    first = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
    notification.stub(:status => :cancelada)

    NotificationHandler.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to first when status is devolvida" do
    first = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
    notification.stub(:status => :devolvida)

    NotificationHandler.handle(notification)

    expected = Order.find(order.id)
    expected.order_status.should == first
    expected.followed_payment_link?.should be_false
  end

  it "should update trademark order status to during payment when status is em analise" do
    during_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) 
    notification.stub(:status => :em_analise)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to during payment when status is aguardando pagamento" do
    during_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) 
    notification.stub(:status => :aguardando_pagamento)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == during_payment
  end

  it "should update trademark order status to after payment when status is paga" do
    after_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) 
    notification.stub(:status => :paga)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

  it "should update trademark order status to after payment when status is disponivel" do
    after_payment = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) 
    notification.stub(:status => :disponivel)
    
    NotificationHandler.handle(notification)

    Order.find(order.id).order_status.should == after_payment
  end

end
