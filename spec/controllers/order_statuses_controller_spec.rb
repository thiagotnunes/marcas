require 'spec_helper'

describe OrderStatusesController do

  before :each do
    ignore_security
  end

  it "should remove first flag from order status when a new one is requested" do
    OrderStatus.should_receive(:remove_first_flag)
    
    post :create, parameters_with_first_status
  end

  it "should not remove first flag when no new one is requested" do
    OrderStatus.should_not_receive(:remove_first_flag)
    
    post :create, parameters_without_first_status 
  end

  it "should remove first flag when a new one is updated for the given order status" do
    OrderStatus.should_receive(:find).and_return(FactoryGirl.create(:order_status))
    OrderStatus.should_receive(:remove_first_flag)
    
    put :update, parameters_with_first_status
  end

  it "should not remove first flag when a new one is updated for the given order status" do
    OrderStatus.should_receive(:find).and_return(FactoryGirl.create(:order_status))
    OrderStatus.should_not_receive(:remove_first_flag)
    
    put :update, parameters_without_first_status
  end

  it "should not remove first flag when updating one which is already the first" do
    OrderStatus.should_receive(:find).and_return(FactoryGirl.create(:order_status, :first_status => "1"))
    OrderStatus.should_not_receive(:remove_first_flag)

    put :update, parameters_with_first_status
  end

  private

  def parameters_with_first_status
    parameters("1")
  end

  def parameters_without_first_status
    parameters("0")
  end

  def parameters(first_status)
    {
      :order_status => {
        "status" => "Status",
        "color" => "#FF0000",
        "first_status" => first_status
      }
    }
  end
end
