module OrderStatusesHelper
  def formatted_first_status_for(order_status)
    if order_status.first?
      raw '<i class="icon-ok"></i>'
    else
      raw '<i class="icon-remove"></i>'
    end
  end
end
