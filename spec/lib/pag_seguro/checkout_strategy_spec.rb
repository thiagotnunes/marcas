require 'spec_helper'

describe PagSeguro::CheckoutStrategy do

  subject { PagSeguro::CheckoutStrategy.new }

  it "should get the return url for the order" do
    resp = stub
    order = stub
    payment = stub
    parser = stub

    PagSeguro::Payment.stub(:new).and_return(payment)
    payment.stub(:post_payment_for).with(order).and_return(resp)
    PagSeguro::ResponseParser.stub(:new).with(resp).and_return(parser)
    parser.stub(:checkout_code).and_return("code")
    PagSeguro.stub(:config).and_return({ "return_to" => "return_url" })

    subject.url_for(order).should == "#{PagSeguro::CheckoutStrategy::URL}code"
  end
end

