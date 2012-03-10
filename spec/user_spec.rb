require 'spec_helper'

describe User do

  context "Generic user" do
    subject { Factory(:user) }

    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }
  end

  context "Customer" do
    let(:customer) { Factory(:customer) }

    it 'should not be an admin' do
      customer.admin?.should be_false
    end
  end

  context "Administrator" do
    let(:admin) { Factory(:admin) }

    it "should be an admin" do
      admin.admin?.should be_true  
    end
  end
  
end
