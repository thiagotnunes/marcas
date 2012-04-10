require 'spec_helper'

describe Service do
  subject { FactoryGirl.create(:service) }

  it { should belong_to :order_type }
  it { should have_many :orders }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should ensure_length_of(:name).is_at_least(3) }
  it { should ensure_length_of(:name).is_at_most(50) }

  it { should_not validate_presence_of :description }

  it { should validate_presence_of :price }
  it { should validate_numericality_of :price }
  
  it { should validate_presence_of :order_type_id }

  it "should find by order type name" do
    another_order_type = FactoryGirl.create(:order_type,  :name => "Another Name")
    FactoryGirl.create(:service, :order_type_id => another_order_type.id)

    order_type = FactoryGirl.create(:order_type,  :name => "Name")
    services = [FactoryGirl.create(:service, :order_type_id => order_type.id)]

    Service.find_by_order_type_name("Name").should == services
  end
end
