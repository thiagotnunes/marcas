require 'spec_helper'

describe OrderAttachment do
  subject { Factory(:order_attachment) }

  it { should validate_presence_of :file }
  it { should validate_uniqueness_of :file }
  it { should ensure_length_of(:file).is_at_least(3) }
  it { should ensure_length_of(:file).is_at_most(200) }

  it { should validate_presence_of :filetype }
  it { should ensure_length_of(:filetype).is_at_least(3) }
  it { should ensure_length_of(:filetype).is_at_most(50) }
end
