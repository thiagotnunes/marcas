require 'spec_helper'

describe OrderStatus do

  subject { Factory(:order_status) }

  it { should have_many :trademark_orders }

  it { should validate_presence_of :status } 
  it { should ensure_length_of(:status).is_at_least(3) } 
  it { should ensure_length_of(:status).is_at_most(20) } 
  it { should validate_uniqueness_of :status }
  it { should allow_mass_assignment_of(:status) }

  it { should_not validate_presence_of :description } 
  it { should allow_mass_assignment_of(:description) }

  it { should validate_presence_of :first_status }

  it "should not be first" do
    status = Factory(:order_status)
    status.first?.should be_false 
  end

  it "should be first" do
    status = Factory(:order_status, :first_status => 1)
    status.first?.should be_true 
  end

  it "should change first status element to false" do
    Factory(:order_status)
    Factory(:order_status, :first_status => 1) 
    Factory(:order_status) 

    OrderStatus.remove_first_flag

    OrderStatus.all.each do |status|
      status.first?.should be_false
    end
  end

  it "should find first" do
    Factory(:order_status)
    first = Factory(:order_status, :first_status => 1) 
    Factory(:order_status) 

    OrderStatus.find_first.should == first
  end
end
