class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create, :activate]
  load_and_authorize_resource :except => [:new, :create, :activate]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.role = :customer

    if @user.save
      redirect_to root_url, notice: 'User was successfully created. A mail have been sent to your email, please check it to activate your account'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url, notice: "#{@user.username} was removed"
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(login_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end
end
