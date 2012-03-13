class SessionsController < ApplicationController

  include SslRequirement
  ssl_exceptions 

  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => t('user.messages.login')
    else
      flash.now.alert = t('user.messages.error.invalid_login')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => t('user.messages.logout')
  end
  
end
