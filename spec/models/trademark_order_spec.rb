require 'spec_helper'

describe TrademarkOrder do
  subject { Factory(:trademark_order) }

  it { should validate_presence_of(:segment) }
  it { should ensure_length_of(:segment).is_at_least(3) }
  it { should ensure_length_of(:segment).is_at_most(100) }

  it { should validate_presence_of(:subsegment) }
  it { should ensure_length_of(:subsegment).is_at_least(3) }
  it { should ensure_length_of(:subsegment).is_at_most(100) }

  it { should belong_to(:user) }
  it { should belong_to(:service) }
  it { should belong_to(:order_status) }
end
