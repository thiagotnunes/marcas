class OrderStatusesController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource

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
    
    handle_status

    if @order_status.save
      redirect_to @order_status, notice: t('order_statuses.flash.create.notice')
    else
        render :new
    end
  end

  def update
    @order_status = OrderStatus.find(params[:id])

    handle_status

    if @order_status.update_attributes(params[:order_status])
        redirect_to @order_status, notice: t('order_statuses.flash.update.notice')
    else
      render :edit
    end
  end

  def destroy
    @order_status = OrderStatus.find(params[:id])
    @order_status.destroy

    redirect_to order_statuses_url
  end

  private

  def handle_status
    if new_first_status
      remove_current_first_status
    end
  end

  def remove_current_first_status
    OrderStatus.remove_first_flag 
  end

  def new_first_status
    params[:order_status]["first_status"] == "1"
  end
end
