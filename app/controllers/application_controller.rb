class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_for_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def not_authenticated
    redirect_to login_path, :alert => "Please login first."
  end

  private

  def layout_for_user
    (current_user && current_user.admin?) ? "admin" : "customer"
  end

end
