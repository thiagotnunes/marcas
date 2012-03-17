require 'spec_helper'

describe OrderStatus do

  subject { Factory(:order_status) }

  it { should validate_presence_of :status } 
  it { should ensure_length_of(:status).is_at_least(3) } 
  it { should ensure_length_of(:status).is_at_most(20) } 
  it { should validate_uniqueness_of :status }
  it { should allow_mass_assignment_of(:status) }

  it { should_not validate_presence_of :description } 
  it { should allow_mass_assignment_of(:description) }

  it { should validate_presence_of :color } 
  it { should ensure_length_of(:color).is_equal_to(7) } 
  it { should allow_value("#FF0000").for(:color) }
  it { should_not allow_value("FF0000").for(:color) }
  it { should_not allow_value("xFF0000").for(:color) }
  it { should allow_mass_assignment_of(:color) }

end
