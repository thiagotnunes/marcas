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

  it "should handle notification" do
    NotificationHandler.should_receive(:handle)

    post :order_confirmation
  end

  it "should pay an order sending a request to pagseguro" do
    billing = stub
    pagseguro_order = stub
    order = FactoryGirl.create(:order)

    @controller.should_receive(:authorize!).with(:pay, order).and_return(true)

    PagSeguro::Order.stub(:new).with(order.invoice.id).and_return(pagseguro_order)
    pagseguro_order.should_receive(:add).with({ id: order.id, price: order.service.price, description: order.service.name})

    UserBilling.stub(:new).and_return(billing)
    billing.should_receive(:pay).with(pagseguro_order)

    post :pay, { :id => order.id }

    response.should redirect_to :trademark_orders
  end
end
