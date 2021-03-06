require_relative '../../../lib/pag_seguro/notification'
require_relative '../../../lib/pag_seguro/notification_response_parser'
require_relative '../../../lib/pag_seguro/bad_response'

describe PagSeguro::NotificationResponseParser do
  let(:file_path) { File.join('spec', 'lib', 'pag_seguro', 'responses') }

  it "should get status aguardando pagamento for 1" do
    assert_notification(:aguardando_pagamento)
  end

  it "should get status em analise for 2" do
    assert_notification(:em_analise)
  end

  it "should get status paga for 3" do
    assert_notification(:paga)
  end

  it "should get status disponivel for 4" do
    assert_notification(:disponivel)
  end

  it "should get status em disputa for 5" do
    assert_notification(:em_disputa)
  end

  it "should get status devolvida for 6" do
    assert_notification(:devolvida)
  end

  it "should get status cancelada for 7" do
    assert_notification(:cancelada)
  end

  it "should raise an error when response is not ok" do
    xml = File.open(File.join(file_path, 'paga.xml'))
    response = stub(:code => "400", :body => 'cancelada.xml')
    lambda {
      PagSeguro::NotificationResponseParser.new(response)
    }.should raise_error
  end

  def assert_notification(status)
    xml = File.open(File.join(file_path, "#{status}.xml"))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.notification.reference.should == "REF1234"
    notification_response.notification.status.should == status
  end
end
