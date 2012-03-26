require 'spec_helper'

describe Service do
  subject { Factory(:service) }

  it { should belong_to :order_type }
  it { should have_many :trademark_orders }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should ensure_length_of(:name).is_at_least(3) }
  it { should ensure_length_of(:name).is_at_most(50) }

  it { should_not validate_presence_of :description }

  it { should validate_presence_of :price }
  it { should validate_numericality_of :price }
  
  it { should validate_presence_of :order_type_id }

  it "should find by order type name" do
    another_order_type = Factory(:order_type,  :name => "Another Name")
    Factory(:service, :order_type_id => another_order_type.id)

    order_type = Factory(:order_type,  :name => "Name")
    services = [Factory(:service, :order_type_id => order_type.id)]

    Service.find_by_order_type_name("Name").should == services
  end
end
