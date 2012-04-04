class NotificationHandler
  @@handler = {
    :verifying => lambda { |order| after_payment_status_for(order) },
    :pending => lambda { |order| after_payment_status_for(order) },
    :canceled => lambda { |order| first_status_for(order) },
    :refunded => lambda { |order| first_status_for(order) },
  }

  def self.handle(notification)
    notification.products.each do |product|
      order = TrademarkOrder.find(product[:id])
      @@handler[notification.status].call(order)
    end
  end

  private

  def self.after_payment_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_after_payment.id)
  end

  def self.first_status_for(order)
    order.update_attribute(:order_status_id, OrderStatus.find_first.id)
  end
end
