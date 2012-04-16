require 'net/https'
require 'uri'

module PagSeguro
  class CheckoutStrategy
    URL = "https://pagseguro.uol.com.br/v2/checkout/payment.html?code="

    def initialize
      @payment = PagSeguro::Payment.new
    end

    def url_for(order)
      response = @payment.post_payment_for(order)
      parser = PagSeguro::ResponseParser.new(response)

      "#{URL}#{parser.checkout_code}"
    end
  end
end
