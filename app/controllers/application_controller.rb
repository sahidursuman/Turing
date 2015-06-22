class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Make the functions below avaliable to all views
  helper_method :current_user, :logged_in?, :wipe_staff, :wipe_staff?, :ship_staff, :ship_staff?, :rec_staff, :rec_staff?, :decom_staff, :decom_staff?

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
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def admin_user
    unless current_user.admin?
    flash[:danger] = "You must be a system administrator to perform that action."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  # Assigning Departmental Privileges
  def wipe_staff?
    current_user.types.any? {|type| type.department.downcase == "wiping" or current_user.admin? }
  end
  
  def wipe_staff
    if !wipe_staff?
      flash[:danger] = "You do not have the correct privileges to perform that action. Please see you sysadmin if you require access."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def ship_staff?
    current_user.types.any? {|type| type.department.downcase == "shipping" or current_user.admin? }
  end
  
  def ship_staff
    if !ship_staff?
      flash[:danger] = "You do not have the correct privileges to perform that action. Please see you sysadmin if you require access."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def rec_staff?
    current_user.types.any? {|type| type.department.downcase == "receiving" or current_user.admin? }
  end
  
  def rec_staff
    if !rec_staff?
      flash[:danger] = "You do not have the correct privileges to perform that action. Please see you sysadmin if you require access."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def decom_staff?
    current_user.types.any? {|type| type.department.downcase == "Decommissioning" or current_user.admin? }
  end
  
  def decom_staff
    if !decom_staff?
    flash[:danger] = "You do not have the correct privileges to perform that action. Please see you sysadmin if you require access."
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  # Barcode Requirements 
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'
  
end