require_relative '../../../lib/pag_seguro/notification'

describe PagSeguro::NotificationRequest do
  it "should create a notification request from hash" do
    attributes = {
      "notificationCode" => "code",
      "notificationType" => "type"
    }

    notification = PagSeguro::NotificationRequest.new(attributes)

    notification.code.should == "code"
    notification.type.should == "type"
  end
end
