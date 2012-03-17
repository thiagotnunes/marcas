class OrderStatusesController < ApplicationController

  def index
    @order_statuses = OrderStatus.all
  end

  def show
    @order_status = OrderStatus.find(params[:id])
  end

  def new
    @order_status = OrderStatus.new
  end

  def edit
    @order_status = OrderStatus.find(params[:id])
  end

  def create
    @order_status = OrderStatus.new(params[:order_status])

    if @order_status.save
      redirect_to @order_status, notice: 'Order status was successfully created.'
    else
        render :new
    end
  end

  def update
    @order_status = OrderStatus.find(params[:id])

    if @order_status.update_attributes(params[:order_status])
        redirect_to @order_status, notice: 'Order status was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @order_status = OrderStatus.find(params[:id])
    @order_status.destroy

    redirect_to order_statuses_url
  end
end
