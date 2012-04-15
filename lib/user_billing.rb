require 'rubygems'
require 'net/http'
require 'net/https'
require 'uri'
require 'pry'

class UserBilling

  def data_from(order)
    data = {
      "encoding" => "UTF-8",
      "email_cobranca" => PagSeguro.config["email"],
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

    data
  end
end
