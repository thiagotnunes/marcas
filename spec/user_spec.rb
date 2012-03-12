require 'spec_helper'

describe User do

  context "Generic user" do
    subject { Factory(:user) }

    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should validate_presence_of :email }

    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }

    it { should_not allow_value("invalidMail").for(:email) }

    it { should ensure_length_of(:username).is_at_least(3) }
    it { should ensure_length_of(:username).is_at_most(20) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should ensure_length_of(:password).is_at_most(30) }
    
  end

  context "Customer" do
    let(:customer) { Factory(:customer) }

    it "should be a customer" do
      customer.customer?.should be_true
    end

    it "should not be an admin" do
      customer.admin?.should be_false
    end
  end

  context "Administrator" do
    let(:admin) { Factory(:admin) }

    it "should not be a customer" do
      admin.customer?.should be_false
    end
    
    it "should be an admin" do
      admin.admin?.should be_true  
    end
  end
  
end
