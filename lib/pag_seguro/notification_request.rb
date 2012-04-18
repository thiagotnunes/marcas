require 'uri'
require 'net/https'

module PagSeguro
  class NotificationRequest
    URL = "https://ws.pagseguro.uol.com.br/v2/transactions/notifications"

    attr_reader :code, :type

    def initialize(attributes)
      @code = attributes["notificationCode"]
      @type = attributes["notificationType"]
    end

    def check_data
      uri = URI.parse(request_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)

      http.request(request)
    end

    private

    def request_url
      "#{URL}/#{@code}?email=#{PagSeguro.config["email"]}&token=#{PagSeguro.config["token"]}"
    end
  end
end
