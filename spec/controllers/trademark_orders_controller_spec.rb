require 'spec_helper'

describe TrademarkOrdersController do

  before :each do
    ignore_security
  end

  it "should fetch all the services to create a trademark order" do
    services = [FactoryGirl.create(:service)]
    Service.stub(:find_by_order_type_name).and_return(services)
    get :new
    assigns(:services).should == services
  end

  it "should create a trademark order with the current user and first order status" do
    user = FactoryGirl.create(:customer) 
    FactoryGirl.create(:order_status)
    first_status = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
    FactoryGirl.create(:order_status)

    login_user(user)
    post :create, {:trademark_order => FactoryGirl.attributes_for(:trademark_order)}

    trademark_order = TrademarkOrder.first
    trademark_order.order_status.should == first_status
    trademark_order.user.should == user

    response.should redirect_to checkout_path(trademark_order)
  end

  it "should update the status for the given order" do
    first_status = FactoryGirl.create(:order_status, :status => "First status")
    second_status = FactoryGirl.create(:order_status, :status => "Second status")
    id = FactoryGirl.create(:trademark_order, :order_status_id => first_status.id).id

    put :update_status, { :id => id, :trademark_order => { :order_status_id => second_status.id } }

    TrademarkOrder.find(id).order_status.should == second_status
  end

  it "should list all the trademark_orders for the customer" do
    user = FactoryGirl.create(:customer) 
    first = FactoryGirl.create(:trademark_order, :user_id => user.id)
    second = FactoryGirl.create(:trademark_order, :user_id => user.id)
    third = FactoryGirl.create(:trademark_order)

    login_user(user)
    get :index

    assigns(:trademark_orders).should == [second, first]
  end

  it "should list all the trademark_orders when the user is admin" do
    admin = FactoryGirl.create(:admin) 
    first = FactoryGirl.create(:trademark_order)
    second = FactoryGirl.create(:trademark_order)
    third = FactoryGirl.create(:trademark_order)

    login_user(admin)
    get :index

    assigns(:trademark_orders).should == [third, second, first]
  end
  
end
