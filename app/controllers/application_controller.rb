class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  check_authorization
  protect_from_forgery with: :exception

  private 

  def current_user
    User.new(session[:id])
  end

  helper_method :current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

end
