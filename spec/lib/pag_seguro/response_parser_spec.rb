require 'spec_helper'

describe PagSeguro::ResponseParser do

  it "retrieve the checkout code from the response" do
    req = stub(:code => "200", :body => "<checkout><code>abcde</code></checkout>")
    parser = PagSeguro::ResponseParser.new(req)

    parser.checkout_code.should == "abcde"
  end

  it "should raise an error when response code is not ok" do
    req = stub(:code => "400", :body => "")

    lambda {
      PagSeguro::ResponseParser.new(req)
    }.should raise_error
  end
  
end
