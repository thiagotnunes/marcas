class NotificationHandler
  def initialize
    @handler = {
      :cancelada => lambda { |order| first_status_for(order) },
      :devolvida => lambda { |order| first_status_for(order) },
      :em_analise => lambda { |order| during_payment_status_for(order) },
      :aguardando_pagamento => lambda { |order| during_payment_status_for(order) },
      :paga => lambda { |order| after_payment_status_for(order) },
      :disponivel => lambda { |order| after_payment_status_for(order) }
    }
    @logger = Logger.new(STDERR)
  end

  def handle(notification)
    begin
      order = Order.find(notification.reference)
      handler = handler_for(notification.status)
      handler.call(order)
    rescue ActiveRecord::RecordNotFound
      order_not_found(notification)
    rescue UnknownNotification
      unknown_notification(notification)
    end
  end

  private

  def handler_for(status)
    handler = @handler[status]
    unless handler.present?
      raise UnknownNotification
    end
    handler
  end

  def first_status_for(order)
    order.order_status = OrderStatus.find_first
    order.update_attribute(:followed_payment_link, false)
  end

  def during_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_during_payment.id)
  end

  def after_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_after_payment.id)
  end

  def unknown_notification(notification)
    @logger.warn("Unknown notification #{notification.status} was received for order id #{notification.reference}, no action has been taken")
  end

  def order_not_found(notification)
    @logger.warn("Notification #{notification.status} was given for non-existing order #{notification.reference}")
  end

  class UnknownNotification < StandardError; end
end
