require 'spec_helper'

describe CartController do
  before :each do
    ignore_security
  end

  it "should create an order with trademark order details" do
    order = FactoryGirl.create(:order)
    @controller.should_receive(:authorize!).with(:checkout, order).and_return(true)

    get :checkout, { :id => order.id }

    invoice = Invoice.find(@controller.pagseguro_order.id)

    @controller.pagseguro_order.products.should == [{:id => order.id, :price => order.service.price * 100, :description => order.service.name, :quantity => 1, :weight => nil, :shipping => nil, :fees => nil }]
    invoice.should_not be_nil 
    Order.find(order.id).invoice.should == invoice
  end

  it "should handle notification" do
    NotificationHandler.should_receive(:handle)

    post :order_confirmation
  end

  it "should pay an order sending a request to pagseguro" do
    order = FactoryGirl.create(:order)
    @controller.should_receive(:authorize!).with(:pay, order).and_return(true)
    billing = stub
    UserBilling.stub(:new).and_return(billing)
    billing.should_receive(:pay).with(order)

    post :pay, { :id => order.id }

    response.should redirect_to :trademark_orders
  end
end
