class TrademarkOrdersController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

  def index
    @trademark_orders = TrademarkOrder.all
  end

  def show
    @trademark_order = TrademarkOrder.find(params[:id])
  end

  def new
    @trademark_order = TrademarkOrder.new
  end

  def edit
    @trademark_order = TrademarkOrder.find(params[:id])
  end

  def create
    @trademark_order = TrademarkOrder.new(params[:trademark_order])

    if @trademark_order.save
      redirect_to @trademark_order, notice: t('trademark_orders.flash.create.notice')
    else
      render :new
    end
  end

  def update
    @trademark_order = TrademarkOrder.find(params[:id])

    if @trademark_order.update_attributes(params[:trademark_order])
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
