class LoginsController < ApplicationController 
  
  # When logging in, or creating a session, user information is stored in the
  # browser as a cookie. When logging out, that information is invalidated.
  # No model or table is used. 
  
  def new
    
  end
  
  def create
    # We can use a local variable instead of an instance variable as no CRUD
    # actions are being performed
    staff = Staff.find_by(staff_email: params[:staff_email])
    if staff && staff.authenticate(params[:password])
      # Create sessions 
      session[:staff_id] = staff.id
      # Logging message and redirect
      flash[:success] = "You have successfully logged in"
      redirect_to home_path
    else
      flash.now[:danger] = "Your email address or password does not match"
      render 'new'
    end
  end
  
  def destroy
    # Invalidate session
    session[:staff_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to root_path
  end
  
end