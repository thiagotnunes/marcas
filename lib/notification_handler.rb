class NotificationHandler
  @@handler = {
    :canceled => lambda { |order| first_status_for(order) },
    :refunded => lambda { |order| first_status_for(order) },
    :verifying => lambda { |order| during_payment_status_for(order) },
    :pending => lambda { |order| during_payment_status_for(order) },
    :completed => lambda { |order| after_payment_status_for(order) },
    :approved => lambda { |order| after_payment_status_for(order) }
  }

  def self.handle(notification)
    notification.products.each do |product|
      order = Order.find(product[:id])
      @@handler[notification.status].call(order)
    end
  end

  private

  def self.first_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_first.id)
  end

  def self.during_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_during_payment.id)
  end

  def self.after_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_after_payment.id)
  end

end
