require 'spec_helper'

describe Invoice do
  subject { FactoryGirl.create(:invoice) }

  it { should have_many :trademark_orders }
  
end
