class CartController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :verify_authenticity_token, :only => :order_confirmation

  attr_reader :pagseguro_order

  def checkout
    @order = Order.find(params[:id])
    authorize! :checkout, @order

    @order.invoice = Invoice.create!
    @order.save!

    @pagseguro_order = PagSeguro::Order.new(@order.invoice.id)
    @pagseguro_order.add id: @order.id, price: @order.service.price, description: @order.service.name
  end

  def order_confirmation
    if request.post?
      pagseguro_notification do |notification|
        NotificationHandler.handle(notification)
      end

      render :nothing => true
    else
      redirect_to :trademark_orders, :notice => t("trademark_orders.flash.index.confirmation.notice")
    end
  end

  def pay
    @order = Order.find(params[:id])
    authorize! :pay, @order

    billing = UserBilling.new(request)
    billing.pay(@order)

    redirect_to :trademark_orders, :notice => t("trademark_orders.flash.index.payment.notice")
  end

end
