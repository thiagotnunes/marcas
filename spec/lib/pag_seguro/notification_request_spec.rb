require 'uri'
require 'net/https'
require_relative '../../../lib/pag_seguro/notification_request'

describe PagSeguro::NotificationRequest do

  let(:notification) do 
    attributes = {
      "notificationCode" => "code",
      "notificationType" => "type"
    }
    PagSeguro::NotificationRequest.new(attributes)
  end

  it "should create a notification request from hash" do
    notification.code.should == "code"
    notification.type.should == "type"
  end

  it "should make a request to pagseguro" do
    uri = stub(:host => "host", :port => 3000, :request_uri => "uri")
    req = stub
    resp = stub
    http = stub
    config = {
      "email" => "email",
      "token" => "token"
    }
    PagSeguro.stub(:config).and_return(config)

    URI.stub(:parse).with("https://ws.pagseguro.uol.com.br/v2/transactions/notifications/code?email=email&token=token").and_return(uri)
    Net::HTTP.stub(:new).with(uri.host, uri.port).and_return(http)
    Net::HTTP::Get.stub(:new).with(uri.request_uri).and_return(req)
    http.should_receive(:use_ssl=).with(true)
    http.should_receive(:request).with(req).and_return(resp)

    notification.check_data.should == resp
  end
end
