require 'spec_helper'

describe CartController do
  before :each do
    ignore_security
  end

  it "should create an order with trademark order details" do
    order = FactoryGirl.create(:order)
    @controller.should_receive(:authorize!).with(:checkout, order).and_return(true)
    invoice = FactoryGirl.create(:invoice)
    Invoice.stub(:create!).and_return(invoice)

    get :checkout, { :id => order.id }

    Order.find(order.id).invoice.should == invoice
  end

  it "should handle notification when it is a post request" do
    NotificationHandler.should_receive(:handle)

    post :order_confirmation
  end

  it "should pay an order sending a request to pagseguro" do
    billing = stub
    pagseguro_order = stub
    order = stub(:build_pagseguro_order => pagseguro_order)
    order.should_receive(:update_attribute).with(:followed_payment_link, true)
    Order.stub(:find).and_return(order)

    @controller.should_receive(:authorize!).with(:pay, order).and_return(true)

    PagSeguro.stub(:gateway_url).and_return('/gateway')

    UserBilling.stub(:new).and_return(billing)
    billing.should_receive(:data_from).with(pagseguro_order).and_return({})

    post :pay, { :id => 1 }

    response.should redirect_to PagSeguro.gateway_url
  end
end
