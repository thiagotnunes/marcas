class OrderStatusesController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

  def index
    @order_statuses = OrderStatus.find(:all, :order => "first_status")
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
    
    update_first_flag

    if @order_status.save
      redirect_to @order_status, notice: t('order_status.messages.created')
    else
        render :new
    end
  end

  def update
    @order_status = OrderStatus.find(params[:id])

    update_first_flag unless @order_status.first?

    if @order_status.update_attributes(params[:order_status])
        redirect_to @order_status, notice: t('order_status.messages.updated')
    else
      render :new
    end
  end

  def destroy
    @order_status = OrderStatus.find(params[:id])
    @order_status.destroy

    redirect_to order_statuses_url
  end

  private

  def update_first_flag
    OrderStatus.remove_first_flag if new_first_status
  end

  def new_first_status
    params[:order_status]["first_status"] == "1"
  end
end
