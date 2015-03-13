class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_order
  helper_method :current_user
  helper_method :logged_in?


  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end


  def current_user
    if(session[:user_id])
      @current_user ||= User.find(session[:user_id]["$oid"])  
    end
  end

  def logged_in?
    !current_user
  end

 
  def logged_in_user
    unless !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end


  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end


  protected

  
end


