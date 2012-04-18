module PagSeguro
  class NotificationRequest
    attr_reader :code, :type

    def initialize(attributes)
      @code = attributes["notificationCode"]
      @type = attributes["notificationType"]
    end
  end
end
