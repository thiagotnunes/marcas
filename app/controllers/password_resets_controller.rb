class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
        
    @user.deliver_reset_password_instructions! if @user
        
    redirect_to(root_path, :notice => t('password_resets.flash.create.notice'))
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user

    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password!(params[:user][:password])
      redirect_to(login_path, :notice => t('password_resets.flash.update.notice'))
    else
      render :edit
    end
  end
end
