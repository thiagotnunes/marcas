require 'spec_helper'

describe PagSeguro::FakeCheckoutStrategy do
  let(:file_path) { PagSeguro::FakeCheckoutStrategy::FILE_PATH }
  subject { PagSeguro::FakeCheckoutStrategy.new }

  before :each do
    File.unlink(file_path) if File.exist?(file_path)
  end

  it "should create the file if it does not exist" do
    subject.url_for(FactoryGirl.create(:order))

    File.should be_file(file_path)
  end

  it "should not create the file again if it already exists" do
    FileUtils.touch(file_path)
    FileUtils.should_not_receive(:touch)

    subject.url_for(FactoryGirl.create(:order))

    File.should be_file(file_path)
  end

  it "should record order information in file" do
    order = FactoryGirl.create(:order)
    config = {
      "email" => "email",
      "authenticity_token" => "token"
    }
    PagSeguro.stub(:config).and_return(config)

    subject.url_for(order)

    orders = YAML.load_file(file_path)
    actual = orders[order.invoice.id]

    actual["email"].should == "email"
    actual["token"].should == "token"
    actual["currency"].should == "BRL"
    actual["itemQuantity1"].should == "1"
    actual["itemId1"].should == order.id
    actual["itemDescription1"].should == order.service.name
    actual["itemAmount1"].should == "%.2f" % order.service.price
  end
end
