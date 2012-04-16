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

  it "should build pagseguro billing data" do
    config = {
      "email" => "email",
      "authenticity_token" => "token"
    }
    PagSeguro.stub(:config).and_return(config)
    data = {
      "email" => "email",
      "token" => "token",
      "currency" => "BRL",
      "reference" => subject.invoice.id,
      "itemQuantity1" => "1",
      "itemId1" => subject.id,
      "itemDescription1" => subject.service.name,
      "itemAmount1" => ("%.2f" % subject.service.price)
    }

    subject.pagseguro_billing_data.should == data
  end
end
