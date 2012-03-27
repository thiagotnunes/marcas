require 'spec_helper'

describe TrademarkOrdersController do

  before :each do
    ignore_security
  end

  it "should fetch all the services to create a trademark order" do
    services = [Factory(:service)]
    Service.stub(:find_by_order_type_name).and_return(services)
    get :new
    assigns(:services).should == services
  end

  it "should create a trademark order with the current user and first order status" do
    user = Factory(:customer) 
    first_status = Factory(:order_status, :first_status => 1)
    Factory(:order_status, :first_status => 0)

    login_user(user)
    post :create, {:trademark_order => Factory.attributes_for(:trademark_order)}

    trademark_order = TrademarkOrder.first
    trademark_order.order_status.should == first_status
    trademark_order.user.should == user
  end
  
end
