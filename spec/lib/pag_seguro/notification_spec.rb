require_relative '../../../lib/pag_seguro/notification'

describe PagSeguro::Notification do
  it "should convert the reference to integer before returning it" do
    notification = PagSeguro::Notification.new("123", :aguardando_pagamento)

    notification.reference.should == 123
  end
end
