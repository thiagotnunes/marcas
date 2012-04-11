require 'spec_helper'

describe OrderAttachment do
  subject { FactoryGirl.create(:order_attachment) }

  it { should belong_to :order }
end
