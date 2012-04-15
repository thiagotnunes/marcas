require 'spec_helper'

describe Order do
  subject { FactoryGirl.create(:order) }

  it { should belong_to :user }
  it { should belong_to :order_status }
  it { should belong_to :service }
  it { should belong_to :invoice }
  it { should have_many :order_attachments }

  it { should validate_presence_of :user }
  it { should validate_presence_of :order_status }
  it { should validate_presence_of :service }

  it { should allow_mass_assignment_of :order_attachments_attributes }
  it { should_not allow_mass_assignment_of :user }
  it { should_not allow_mass_assignment_of :order_status }
  it { should_not allow_mass_assignment_of :service }
  it { should_not allow_mass_assignment_of :invoice }

  it "should build a pagseguro order from itself" do
    pagseguro_order = PagSeguro::Order.new(subject.invoice.id)
    pagseguro_order.add :id => subject.id, :price => subject.service.price, :description => subject.service.description
    
    pagseguro_order = subject.build_pagseguro_order
    pagseguro_order.id.should == pagseguro_order.id
    pagseguro_order.products.should == pagseguro_order.products
  end

end
