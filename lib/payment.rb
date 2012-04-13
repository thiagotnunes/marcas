require 'rubygems'
require 'net/http'
require 'net/https'
require 'uri'
require 'pagseguro'

class Payment
  def initialize(request)
    @request = request
  end

  def pay(order)
    Net::HTTP.post_form(URI.parse("#{@request.url}#{PagSeguro.gateway_url}"), data_from(order)) 
  end

  private

  def data_from(order)
    data = {
      "encoding" => "UTF-8",
      "email_cobranca" => PagSeguro.config["email"],
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

    data
  end
end
