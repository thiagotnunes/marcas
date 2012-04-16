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

    @order.update_attribute(:followed_payment_link, true)
    checkout = PagSeguro::Checkout.new

    redirect_to checkout.url_for(@order)
  end

end
