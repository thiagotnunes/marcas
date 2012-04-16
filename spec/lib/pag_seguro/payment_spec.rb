require 'spec_helper'

describe PagSeguro::Payment do
  
  it "should post the billing data to the payment url" do
    uri = stub(:host => "host", :port => 3000, :request_uri => "uri")
    request = stub
    response = stub
    http = stub
    fake_data = { "data" => "fake" }
    order = stub(:pagseguro_billing_data => fake_data)

    URI.stub(:parse).with(PagSeguro::Payment::URL).and_return(uri)
    Net::HTTP.stub(:new).with(uri.host, uri.port).and_return(http)
    Net::HTTP::Post.stub(:new).with(uri.request_uri).and_return(request)
    request.should_receive(:set_form_data).with(fake_data)
    http.should_receive(:use_ssl=).with(true)
    http.should_receive(:request).with(request).and_return(response)

    payment = PagSeguro::Payment.new

    payment.post_payment_for(order).should == response
  end
end
