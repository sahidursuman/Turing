class StaffsController < ApplicationController
  before_action :set_staff, only: [:edit, :update, :show]
  before_action :require_user#, except [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:destroy, :index, :new, :create]
  
  def index
    @staffs = Staff.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @wipes = @staff.wipes.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @staff = Staff.new
  end 
  
  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      flash[:success] = "Your account has been created successfully."
      # Start session for user (automatically log in as user when creating user)
      # session[:staff_id] = @staff.id
      redirect_to staff_path(@staff)
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @staff.update(staff_params)
      flash[:success] = "Your profile has been updated successfully."
      redirect_to staff_path(@staff) 
    else
      render 'new'
    end
  end
  
  def destroy
    Staff.find(params[:id]).destroy
    flash[:success] = "The staff member's details have been successfully deleted."
    redirect_to staffs_path
  end
  
  private
  
    def staff_params
      params.require(:staff).permit(:staff_name, :staff_email, :password,
                                    type_ids: [])
    end
    
    def set_staff
      @staff = Staff.find(params[:id])
    end
  
    def require_same_user
      if current_user != @staff and !current_user.admin?
        flash[:danger] = "You may only edit your own profile."
        redirect_to root_path
      end
    end
    
end