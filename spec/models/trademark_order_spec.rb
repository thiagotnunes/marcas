require 'spec_helper'

describe TrademarkOrder do
  subject { FactoryGirl.create(:trademark_order) }

  it { should validate_presence_of(:segment) }
  it { should ensure_length_of(:segment).is_at_least(3) }
  it { should ensure_length_of(:segment).is_at_most(100) }

  it { should validate_presence_of(:subsegment) }
  it { should ensure_length_of(:subsegment).is_at_least(3) }
  it { should ensure_length_of(:subsegment).is_at_most(100) }

  it { should belong_to(:user) }
  it { should belong_to(:service) }
  it { should belong_to(:order_status) }
  it { should have_many(:order_attachments) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:segment) }
  it { should allow_mass_assignment_of(:subsegment) }
  it { should allow_mass_assignment_of(:observations) }
  it { should allow_mass_assignment_of(:service_id) }
  it { should allow_mass_assignment_of(:order_attachments_attributes) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:order_status) }
  
  it "should pay the trademark order" do
    subject.pay
    subject.payed?.should be_true
  end
end
