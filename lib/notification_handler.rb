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
    order = Order.find(notification.reference.to_i)
    handler = @handler[notification.status]
    if handler.present?
      handler.call(order)
    else
      unknown_notification(notification)
    end
  end

  private

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
    
end
