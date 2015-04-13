class ComputersController < ApplicationController
  
  def index
    @computers = Computer.all
  end
  
  def show
    @computer = Computer.find(params[:id])
  end
  
  def new
    @computer = Computer.new
  end
  
  def create
    @computer = Computer.new(computer_params)
    @computer.staff = Staff.find(2)
    
    if @computer.save
      flash[:success] = "You're computer's details have been submitted successfully!"
      redirect_to computers_path
    else
      render :new
    end
  end
  
  def edit
    @computer = Computer.find(params[:id])
  end
  
  def update
    @computer = Computer.find(params[:id])
    if @computer.update(computer_params)
      flash[:success] = "The computer's details have been updated successfully!"
      redirect_to computer_path(@computer)
    else
      render :edit
    end
  end
  
  private
  
    # Whitelisting variables
    def computer_params
      params.require(:computer).permit(:manufacturer, :computer_type, :specification, 
                                       :donor, :model_no, :serial_no, :product_key, 
                                       :action_taken, :data, :date, :initials_flag, 
                                       :picture)
    end
  
end