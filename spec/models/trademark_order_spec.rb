require 'spec_helper'

describe TrademarkOrder do
  subject { FactoryGirl.create(:trademark_order) }

  it { should validate_presence_of(:segment) }
  it { should ensure_length_of(:segment).is_at_least(3) }
  it { should ensure_length_of(:segment).is_at_most(100) }

  it { should validate_presence_of(:subsegment) }
  it { should ensure_length_of(:subsegment).is_at_least(3) }
  it { should ensure_length_of(:subsegment).is_at_most(100) }

  it { should belong_to :purchase }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:segment) }
  it { should allow_mass_assignment_of(:subsegment) }
  it { should allow_mass_assignment_of(:observations) }
  it { should allow_mass_assignment_of(:purchase_attributes) }

  it "should fetch all the trademark orders for the given user" do
    user = FactoryGirl.create(:user)
    another_user = FactoryGirl.create(:user)

    my_order_1 = FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => user.id))
    my_order_2 = FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => user.id))

    FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => another_user.id))
    FactoryGirl.create(:trademark_order, :purchase => FactoryGirl.create(:order, :user_id => another_user.id))

    TrademarkOrder.all_for_user(user).should == [my_order_1, my_order_2]
  end
end
