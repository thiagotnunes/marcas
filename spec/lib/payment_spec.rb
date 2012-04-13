require 'spec_helper'

describe Payment do

  let(:req) { stub }
  let(:email) { "email" }
  let(:order) { PagSeguro::Order.new(10) }
  let(:payment) { Payment.new(req) }

  before :each do
    request = stub
    order.add id: 20, price: 10000, description: "Description"
    req.stub(:url).and_return("http://url")
    PagSeguro.stub(:config).and_return(email)
    PagSeguro.stub(:gateway_url).and_return("/gateway")
  end

  it "should pay an order" do
    data = {
      "encoding" => "UTF-8",
      "email_cobranca" => email,
      "tipo" => "CP",
      "moeda" => "BRL",
      "ref_transacao" => order.id
    }
    order.products.each.with_index(1) do |product, i|
      data["item_quant_#{i}"] = "1"
      data["item_id_#{i}"] = product[:id]
      data["item_descr_#{i}"] = product[:description]
      data["item_valor_#{i}"] = product[:price]
    end

    Net::HTTP.stub(:post_form).with(URI.parse("http://url/gateway"), data).and_return("302")

    payment.pay(order).should == "302"
  end
end

