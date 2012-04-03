class SessionsController < ApplicationController

  include SslRequirement
  ssl_exceptions 

  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to trademark_orders_url, :notice => t('sessions.flash.create.notice')
    else
      flash.now.alert = t('sessions.flash.create.alert')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => t('sessions.flash.destroy.notice')
  end
  
end
