require 'spec_helper'

describe CartController do
  before :each do
    ignore_security
  end

  it "should create an order with trademark order details" do
    trademark = FactoryGirl.create(:trademark_order)
    @controller.should_receive(:authorize!).with(:checkout, trademark).and_return(true)

    get :checkout, { :id => trademark.id }

    @controller.order.products.should == [{:id => trademark.id, :price => trademark.service.price * 100, :description => trademark.name, :quantity => 1, :weight => nil, :shipping => nil, :fees => nil }]
  end
  
end
