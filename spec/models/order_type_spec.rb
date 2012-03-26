require 'spec_helper'

describe OrderType do
  subject { Factory(:order_type) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should ensure_length_of(:name).is_at_least(3) }
  it { should ensure_length_of(:name).is_at_most(20) }
  it { should have_many :services }

end
