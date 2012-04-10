require 'spec_helper'

describe TrademarkOrdersController do

  before :each do
    ignore_security
  end

  let(:admin) { FactoryGirl.create(:admin) } 
  let(:customer) { FactoryGirl.create(:customer) } 

  context "Listing" do
    let!(:customer_orders) { [FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => customer.id)), FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => customer.id))] }
    let!(:other_orders) { [FactoryGirl.create(:trademark_order), FactoryGirl.create(:trademark_order)] }

    it "should list all the trademark_orders for the customer" do
      login_user(customer)
      get :index

      assigns(:trademark_orders).should == customer_orders
    end

    it "should list all the trademark_orders when the user is admin" do
      login_user(admin)
      get :index

      assigns(:trademark_orders).should == customer_orders + other_orders
    end
  end

  context "Preparing" do
    it "should find all the services existing for the Marcas order type" do
      marcas = FactoryGirl.create(:order_type, :name => "Marcas")
      other = FactoryGirl.create(:order_type, :name => "Other")

      marcas_services = [
        FactoryGirl.create(:service, :order_type => marcas),
        FactoryGirl.create(:service, :order_type => marcas),
        FactoryGirl.create(:service, :order_type => marcas)
      ]

      3.times { FactoryGirl.create(:service, :order_type => other) }

      get :new

      assigns(:services).should == marcas_services
    end
  end

  context "Creating" do
    it "should create a trademark order with valid parameters" do
      status = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first])
      order_type = FactoryGirl.create(:order_type, :name => "Marcas")
      service = FactoryGirl.create(:service, :order_type => order_type)

      login_user(customer)

      post :create, { 
        "order" => {
          "service_id" => service.id,
        },
        "trademark_order" => {
          "name" => "Trademark",
          "segment" => "segment",
          "subsegment" => "subsegment",
          "observations" => "observations"
        }
      }

      @controller.trademark_order.name.should == "Trademark"
      @controller.trademark_order.segment.should == "segment"
      @controller.trademark_order.subsegment.should == "subsegment"
      @controller.trademark_order.observations.should == "observations"
      @controller.trademark_order.purchase.user.should == customer
      @controller.trademark_order.purchase.service.should == service
      @controller.trademark_order.purchase.order_status.should == status
    end
  end

end
