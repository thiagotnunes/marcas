require 'spec_helper'

describe PagSeguro::CheckoutResponseParser do

  it "retrieve the checkout code from the response" do
    req = stub(:code => "200", :body => "<checkout><code>abcde</code></checkout>")
    parser = PagSeguro::CheckoutResponseParser.new(req)

    parser.checkout_code.should == "abcde"
  end

  it "should raise an error when response code is not ok" do
    req = stub(:code => "400", :body => "")

    lambda {
      PagSeguro::CheckoutResponseParser.new(req)
    }.should raise_error
  end
  
end
