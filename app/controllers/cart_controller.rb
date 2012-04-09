class CartController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :verify_authenticity_token, :only => :order_confirmation

  attr_reader :order

  def checkout
    @trademark_order = TrademarkOrder.find(params[:id])
    authorize! :checkout, @trademark_order

    invoice = Invoice.create!
    @trademark_order.invoice = invoice
    @trademark_order.save!

    @order = PagSeguro::Order.new(invoice.id)
    @order.add id: @trademark_order.id, price: @trademark_order.service.price, description: @trademark_order.name
  end

  def order_confirmation
    if request.post?
      pagseguro_notification do |notification|
        NotificationHandler.handle(notification)
      end

      render :nothing => true
    else
      redirect_to :trademark_orders, :notice => t("trademark_orders.flash.index.notice")
    end
  end

end
