require 'spec_helper'

describe TrademarkOrdersController do

  before :each do
    ignore_security
  end

  it "should create a trademark order with the current user" do
    user = Factory(:customer) 
    login_user(user)
    post :create, {:trademark_order => Factory.attributes_for(:trademark_order)}

    trademark_order = TrademarkOrder.first
    trademark_order.user.should == user
  end
  
end
