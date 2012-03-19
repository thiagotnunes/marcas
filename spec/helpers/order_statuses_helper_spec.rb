require 'spec_helper'

describe OrderStatusesHelper do
  it "should print out ok icon for first status when it is the first one" do
    status = Factory(:order_status, :first_status => 1)
    formatted_first_status_for(status).should == '<i class="icon-ok"></i>'
  end
  
  it "should print out remove icon for first status when it is the first one" do
    status = Factory(:order_status)
    formatted_first_status_for(status).should == '<i class="icon-remove"></i>'
  end
end
