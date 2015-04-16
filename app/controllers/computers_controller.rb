class ComputersController < ApplicationController
  before_action :set_computer, only: [:edit, :update, :show]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  
  def index
    # Pagination of computers
    @computers = Computer.paginate(page: params[:page], per_page: 10)
  end
  
  def show

  end
  
  def new
    @computer = Computer.new
  end
  
  def create
    @computer = Computer.new(computer_params)
    @computer.staff = current_user
    if @computer.save
      flash[:success] = "You're computer's details have been submitted successfully!"
      redirect_to computers_path
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @computer.update(computer_params)
      flash[:success] = "The computer's details have been updated successfully!"
      redirect_to computer_path(@computer)
    else
      render :edit
    end
  end
  
  def destroy
    Computer.find(params[:id]).destroy
    flash[:success] = "The computer's details have been successfully deleted."
    redirect_to computers_path
  end
  
  private
  
    # Whitelisting variables
    def computer_params
      params.require(:computer).permit(:manufacturer, :computer_type, :specification, 
                                       :donor, :model_no, :serial_no, :product_key, 
                                       :action_taken, :data, :date, :initials_flag, 
                                       :picture, wipe_ids: [])
    end
    
    def set_computer
      @computer = Computer.find(params[:id])
    end
    
    def require_same_user
      if current_user != @computer.staff and !current_user.admin?
        flash[:danger] = "You may only edit your own computer's details"
        redirect_to computer_path(@computer)
      end
    end
    
    def admin_user
      redirect_to computers_path unless current_user.admin?
    end
    
end