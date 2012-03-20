require 'spec_helper'

describe Service do
  subject { Factory(:service) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should ensure_length_of(:name).is_at_least(3) }
  it { should ensure_length_of(:name).is_at_most(50) }

  it { should_not validate_presence_of :description }

  it { should validate_presence_of :price }
  it { should validate_numericality_of :price }
  
  it { should validate_presence_of :order_type_id }
end
