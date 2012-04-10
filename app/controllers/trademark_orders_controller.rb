class TrademarkOrdersController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

  ORDER_TYPE_NAME = "Marcas"

  attr_reader :trademark_order

  def index
    if current_user.admin?
      @trademark_orders = TrademarkOrder.all
    else
      @trademark_orders = TrademarkOrder.all_for_user(current_user.id)
    end
  end

  def show
    @trademark_order = TrademarkOrder.find(params[:id])
  end

  def new
    @trademark_order = TrademarkOrder.new
    @services = Service.find_by_order_type_name(ORDER_TYPE_NAME)
  end

  def create
    @trademark_order = TrademarkOrder.new(params[:trademark_order])

    @trademark_order.purchase = Order.new
    @trademark_order.purchase.user = current_user
    @trademark_order.purchase.service = Service.find(params[:order][:service_id])
    @trademark_order.purchase.order_status = OrderStatus.find_first

    if @trademark_order.save
      redirect_to checkout_path(@trademark_order.purchase), notice: t('trademark_orders.flash.create.notice')
    else
      render :new
    end
  end

  def destroy
    @trademark_order = TrademarkOrder.find(params[:id])
    @trademark_order.destroy

    redirect_to trademark_orders_url
  end
end
