require 'spec_helper'

describe UserBilling do

  let(:req) { stub }
  let(:email) { "email" }
  let(:order) { PagSeguro::Order.new(10) }
  let(:user_billing) { UserBilling.new(req) }

  before :each do
    order.add id: 20, price: 10000, description: "Description"
    PagSeguro.stub(:config).and_return(email)
  end

  it "should pay an order" do
    data = {
      "encoding" => "UTF-8",
      "email_cobranca" => email,
      "tipo" => "CP",
      "moeda" => "BRL",
      "ref_transacao" => order.id.to_s
    }
    order.products.each.with_index(1) do |product, i|
      data["item_quant_#{i}"] = "1"
      data["item_id_#{i}"] = product[:id].to_s
      data["item_descr_#{i}"] = product[:description]
      data["item_valor_#{i}"] = product[:price].to_s
    end

    user_billing.data_from(order).should == data
  end
end

