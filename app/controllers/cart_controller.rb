class CartController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, :verify_authenticity_token, :only => :order_confirmation

  include SslRequirement
  ssl_exceptions :order_confirmation

  attr_reader :pagseguro_order

  def checkout
    @order = Order.find(params[:id])
    authorize! :checkout, @order

    @order.invoice = Invoice.create!
    @order.save!
  end

  def order_confirmation
    redirect_to :trademark_orders, :notice => t("trademark_orders.flash.index.confirmation.notice")
  end

  def notification
    notification_request = PagSeguro::NotificationRequest.new(params.except("controller", "action"))
    notification_response = notification_request.check_data
    parser = PagSeguro::NotificationResponseParser.new(notification_response)
    NotificationHandler.handle(parser.notification)

    render :nothing => true
  end

  def pay
    @order = Order.find(params[:id])
    authorize! :pay, @order

    @order.update_attribute(:followed_payment_link, true)
    checkout_strategy_factory = PagSeguro::CheckoutStrategyFactory.new
    checkout = checkout_strategy_factory.strategy_for(Rails.env)

    redirect_to checkout.url_for(@order)
  end

end
