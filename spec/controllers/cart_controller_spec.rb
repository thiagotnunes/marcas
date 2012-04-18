require 'spec_helper'

describe CartController do
  before :each do ignore_security
  end

  it "should create an order with trademark order details" do
    order = FactoryGirl.create(:order)
    @controller.should_receive(:authorize!).with(:checkout, order)
    invoice = FactoryGirl.create(:invoice)
    Invoice.stub(:create!).and_return(invoice)

    get :checkout, { :id => order.id }

    Order.find(order.id).invoice.should == invoice
  end

  it "should handle notification" do
    parameters = {
      "notificationCode" => "code",
      "notificationType" => "type" 
    }

    resp = stub
    notification_request = stub(:check_data => resp)
    PagSeguro::NotificationRequest.stub(:new).with(parameters).and_return(notification_request)
    notification = stub
    notification_response_parser = stub(:notification => notification)
    PagSeguro::NotificationResponseParser.stub(:new).with(resp).and_return(notification_response_parser)
    NotificationHandler.should_receive(:handle).with(notification)

    post :notification, parameters
  end

  it "should pay an order redirecting an user to pagseguro" do
    order = FactoryGirl.create(:order, :followed_payment_link => false)
    @controller.should_receive(:authorize!).with(:pay, order)
    strategy = stub
    PagSeguro::CheckoutStrategyFactory.stub(:new).and_return(strategy)
    checkout = stub
    strategy.stub(:strategy_for).with(Rails.env).and_return(checkout)
    checkout.should_receive(:url_for).with(order).and_return("redirection")

    post :pay, { id: order.id }
    
    response.should redirect_to "redirection"
    Order.find(order).followed_payment_link?.should be_true
  end
end
