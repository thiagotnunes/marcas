require_relative '../../../lib/pag_seguro/notification_response_parser'
require_relative '../../../lib/pag_seguro/bad_response'

describe PagSeguro::NotificationResponseParser do
  let(:file_path) { File.join('spec', 'lib', 'pag_seguro', 'responses') }

  it "should get status aguardando pagamento for 1" do
    xml = File.open(File.join(file_path, 'aguardando_pagamento.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :aguardando_pagamento
  end

  it "should get status em analise for 2" do
    xml = File.open(File.join(file_path, 'em_analise.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :em_analise
  end

  it "should get status paga for 3" do
    xml = File.open(File.join(file_path, 'paga.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :paga
  end

  it "should get status disponivel for 4" do
    xml = File.open(File.join(file_path, 'disponivel.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :disponivel
  end

  it "should get status em disputa for 5" do
    xml = File.open(File.join(file_path, 'em_disputa.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :em_disputa
  end

  it "should get status devolvida for 6" do
    xml = File.open(File.join(file_path, 'devolvida.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :devolvida
  end

  it "should get status cancelada for 7" do
    xml = File.open(File.join(file_path, 'cancelada.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.status.should == :cancelada
  end

  it "should get order id based on the transaction reference" do
    xml = File.open(File.join(file_path, 'paga.xml'))
    response = stub(:code => "200", :body => xml.read)
    notification_response = PagSeguro::NotificationResponseParser.new(response)

    notification_response.reference.should == "REF1234"
  end

  it "should raise an error when response is not ok" do
    xml = File.open(File.join(file_path, 'paga.xml'))
    response = stub(:code => "400", :body => 'cancelada.xml')
    lambda {
      PagSeguro::NotificationResponseParser.new(response)
    }.should raise_error
  end
end
