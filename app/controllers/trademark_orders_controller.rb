class TrademarkOrdersController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

  ORDER_TYPE_NAME = "Marcas"

  def index
    @trademark_orders = TrademarkOrder.all
  end

  def show
    @trademark_order = TrademarkOrder.find(params[:id])
  end

  def new
    @trademark_order = TrademarkOrder.new
    @services = Service.find_by_order_type_name(ORDER_TYPE_NAME)
  end

  def edit_status
    @trademark_order = TrademarkOrder.find(params[:id])
  end

  def create
    @trademark_order = TrademarkOrder.new(params[:trademark_order])
    @trademark_order.user = current_user
    @trademark_order.order_status = OrderStatus.find_first

    if @trademark_order.save
      redirect_to @trademark_order, notice: t('trademark_orders.flash.create.notice')
    else
      render :new
    end
  end

  def update_status
    @trademark_order = TrademarkOrder.find(params[:id])
    @trademark_order.order_status = OrderStatus.find(params[:trademark_order][:order_status_id])
    if @trademark_order.save
      redirect_to @trademark_order, notice: t('trademark_orders.flash.update.notice')
    else
      render :edit
    end
  end

  def destroy
    @trademark_order = TrademarkOrder.find(params[:id])
    @trademark_order.destroy

    redirect_to trademark_orders_url
  end
end
