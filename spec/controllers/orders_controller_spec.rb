require 'spec_helper'

describe OrdersController do
  context "Editing" do
    it "should update status for a given trademark order" do
      status = FactoryGirl.create(:order_status)
      trademark = FactoryGirl.create(:order)

      put :update_status, { 
        "id" => trademark.id, 
        "order" => {
          "order_status_id" => status.id
        }
      }

      @controller.order.order_status.should == status
    end
  end
end
