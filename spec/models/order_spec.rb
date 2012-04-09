require 'spec_helper'

describe Order do
  subject { FactoryGirl.create(:order) }

  it { should belong_to :user }
  it { should belong_to :order_status }
  it { should belong_to :service }
  it { should belong_to :invoice }

  it { should validate_presence_of :user }
  it { should validate_presence_of :order_status }
  it { should validate_presence_of :service }
  it { should validate_presence_of :invoice }
  
end
