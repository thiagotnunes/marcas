require 'rexml/document'

module PagSeguro
  class CheckoutResponseParser
    OK = "200"

    def initialize(req)
      raise PagSeguro::BadResponse unless req.code == OK
      @xml = REXML::Document.new req.body
    end

    def checkout_code
      @xml.elements["checkout/code"].text
    end
  end
end
