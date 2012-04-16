require 'spec_helper'

describe CartController do
  before :each do
    ignore_security
  end

  it "should create an order with trademark order details" do
    order = FactoryGirl.create(:order)
    @controller.should_receive(:authorize!).with(:checkout, order)
    invoice = FactoryGirl.create(:invoice)
    Invoice.stub(:create!).and_return(invoice)

    get :checkout, { :id => order.id }

    Order.find(order.id).invoice.should == invoice
  end

  it "should handle notification when it is a post request" do
    NotificationHandler.should_receive(:handle)

    post :order_confirmation
  end

  it "should pay an order redirecting an user to pagseguro" do
    order = FactoryGirl.create(:order, :followed_payment_link => false)
    @controller.should_receive(:authorize!).with(:pay, order)
    checkout = stub
    PagSeguro::Checkout.stub(:new).and_return(checkout)
    checkout.should_receive(:url_for).with(order).and_return("redirection")

    post :pay, { id: order.id }
    
    response.should redirect_to "redirection"
    Order.find(order).followed_payment_link?.should be_true
  end
end
