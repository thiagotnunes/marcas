class UsersController < ApplicationController
  before_filter :require_login, :except => [:new, :create, :activate]
  load_and_authorize_resource :except => [:new, :create, :activate]

  include SslRequirement
  ssl_exceptions

  attr_writer :user

  def index
    @users = User.all_customers
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

  def edit_password
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.role = :customer

    if @user.save
      redirect_to root_url, notice: t('users.flash.create.notice')
    else
      render :new
    end
  end

  def update
    render :edit
  end

  def update_password
    if change_password(params[:user])
      redirect_to root_url, notice: t('users.flash.update_password.notice')
    else
      render :edit_password
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_url, notice: t('users.flash.destroy.notice')
  end

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to login_path, :notice => t('users.flash.activate.notice')
    else
      not_authenticated
    end
  end

  private

  def change_password(attributes)
    unless login(@user.username, attributes["old_password"])
      @user.errors.add(:old_password, t('activerecord.errors.messages.invalid'))
      return false
    end
    @user.password = attributes["password"]
    @user.password_confirmation = attributes["password_confirmation"]
    @user.save! if @user.valid?
  end
end
