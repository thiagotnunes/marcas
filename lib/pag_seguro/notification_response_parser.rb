require 'rexml/document'

module PagSeguro
  class NotificationResponseParser
    STATUS_MAPPING = {
      "1" => :aguardando_pagamento,
      "2" => :em_analise,
      "3" => :paga,
      "4" => :disponivel,
      "5" => :em_disputa,
      "6" => :devolvida,
      "7" => :cancelada
    }

    def initialize(response)
      @xml = REXML::Document.new response.body
    end

    def status
      STATUS_MAPPING[@xml.elements["transaction/status"].text]
    end

    def reference
      @xml.elements["transaction/reference"].text
    end
  end
end
