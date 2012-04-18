class NotificationHandler
  @@handler = {
    :cancelada => lambda { |order| first_status_for(order) },
    :devolvida => lambda { |order| first_status_for(order) },
    :em_analise => lambda { |order| during_payment_status_for(order) },
    :aguardando_pagamento => lambda { |order| during_payment_status_for(order) },
    :paga => lambda { |order| after_payment_status_for(order) },
    :disponivel => lambda { |order| after_payment_status_for(order) }
  }

  def self.handle(notification)
    notification.products.each do |product|
      order = Order.find(product[:id])
      @@handler[notification.status].call(order)
    end
  end

  private

  def self.first_status_for(order)
    order.order_status = OrderStatus.find_first
    order.followed_payment_link = false
    order.save!
  end

  def self.during_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_during_payment.id)
  end

  def self.after_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_after_payment.id)
  end

end
