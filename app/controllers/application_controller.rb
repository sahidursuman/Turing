class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Make the functions below avaliable to all views
  helper_method :current_user, :logged_in?
  
  # Only returns current user if session exists
  # Uses memoization to speed up accesor methods by saving/storing the call 
  # to a @current_user instance variable 
  # Note that x ||= y means exactly x || (x = y)
  def current_user
    @current_user ||= Staff.find(session[:staff_id]) if session[:staff_id]
  end
  
  # Converts current_user into a boolean true/false
  def logged_in?
    !!current_user
  end
  
  # Checks whether any user is logged in
  # Note that an ! before a function means not, so if not true (false)
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def admin_user
    redirect_to computers_path unless current_user.admin?
  end
  
end

