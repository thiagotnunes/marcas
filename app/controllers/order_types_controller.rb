class OrderTypesController < ApplicationController
  before_filter :require_login
  load_and_authorize_resource
  
  def index
    @order_types = OrderType.all
  end

  def show
    @order_type = OrderType.find(params[:id])
  end

  def new
    @order_type = OrderType.new
  end

  def edit
    @order_type = OrderType.find(params[:id])
  end

  def create
    @order_type = OrderType.new(params[:order_type])

    if @order_type.save
      redirect_to @order_type, notice: t('order_types.flash.create.notice')
    else
      render :new
    end
  end

  def update
    @order_type = OrderType.find(params[:id])

    if @order_type.update_attributes(params[:order_type])
      redirect_to @order_type, notice: t('order_types.flash.update.notice')
    else
      render :edit
    end
  end

  def destroy
    @order_type = OrderType.find(params[:id])
    @order_type.destroy

    redirect_to order_types_url
  end
end
