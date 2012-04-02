require 'spec_helper'

describe OrderStatusesHelper do
  YES = '<i class="icon-ok"></i>'
  NO = '<i class="icon-remove"></i>'

  it "should print out ok icon for first status when it is the first one" do
    checkbox_formatted(1).should == YES
  end
  
  it "should print out remove icon for first status when it is the first one" do
    checkbox_formatted(0).should == NO
  end
end
