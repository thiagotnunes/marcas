require 'uri'
require 'net/https'

module PagSeguro

  class Payment
    URL = "https://ws.pagseguro.uol.com.br/v2/checkout"

    def post_payment_for(order)
      uri = URI.parse(URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(order.pagseguro_billing_data)

      http.request(request)
    end
  end
end
