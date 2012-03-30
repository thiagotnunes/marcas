require 'spec_helper'

describe OrderAttachment do
  subject { Factory(:order_attachment) }

  it { should belong_to :trademark_order }
end
