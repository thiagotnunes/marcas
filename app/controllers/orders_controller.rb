class OrdersController < ApplicationController

  attr_reader :order

  def edit_status
    @order = Order.find(params[:id])
  end

  def update_status
    @order = Order.find(params[:id])
    @order.order_status = OrderStatus.find(params[:order][:order_status_id])
    if @order.save
      redirect_to trademark_orders_path, notice: t('orders.flash.update.notice')
    else
      render :edit_status
    end
  end
end
