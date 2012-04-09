require 'spec_helper'

describe OrderStatus do

  subject { FactoryGirl.create(:order_status) }

  it { should have_many :trademark_orders }

  it { should validate_presence_of :status } 
  it { should ensure_length_of(:status).is_at_least(3) } 
  it { should ensure_length_of(:status).is_at_most(50) } 
  it { should validate_uniqueness_of :status }
  it { should allow_mass_assignment_of(:status) }

  it { should_not validate_presence_of :description } 
  it { should allow_mass_assignment_of(:description) }

  it { should validate_presence_of :color }

  it { should validate_presence_of :lifecycle }

  context "Finding through lifecycle" do
    before :each do
      FactoryGirl.create(:order_status)
      FactoryGirl.create(:order_status) 
    end

    it "should find first" do
      model = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:first]) 

      OrderStatus.find_first.should == model
    end

    it "should find during payment" do
      model = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:during_payment]) 

      OrderStatus.find_during_payment.should == model
    end

    it "should find after payment" do
      model = FactoryGirl.create(:order_status, :lifecycle => OrderStatus::LIFECYCLES[:after_payment]) 

      OrderStatus.find_after_payment.should == model
    end
  end

  context "Dealing with order status lifecycle" do
    it "should not allow creation with a lifecycle outside of pre-defined ones" do
      FactoryGirl.create(:order_status, :lifecycle => 'invalid') 
    end

    it "should allow creation with a lifecycle within pre-defined values" do
      FactoryGirl.create(:order_status, :lifecycle => 'first') 
    end
  end

end
