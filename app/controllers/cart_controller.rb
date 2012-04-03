class CartController < ApplicationController
  before_filter :require_login

  attr_reader :order

  def checkout
    @trademark_order = TrademarkOrder.find(params[:id])
    authorize! :checkout, @trademark_order

    @order = PagSeguro::Order.new(1)
    @order.add id: @trademark_order.id, price: @trademark_order.service.price, description: @trademark_order.name
  end
end
