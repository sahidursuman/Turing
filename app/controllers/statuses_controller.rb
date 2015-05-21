class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :show]
  before_action :require_user
  before_action :wipe_staff
  before_action :admin_user, only: [:destroy]
  
  def index
    @statuses = Status.paginate(page: params[:page], per_page: 50)
  end
  
  def show

  end
  
  def new
    @status = Status.new
  end 
  
  def create
    @status = Status.new(status_params)
    @status.staff = current_user
    if @status.save
      flash[:success] = "Your computer's status details have been successfully logged."
      redirect_to status_path(@status)
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @status.update(status_params)
      flash[:success] = "Your computer's status details have been successfully updated."
      redirect_to status_path(@status) 
    else
      render 'new'
    end
  end
  
  def destroy
    Status.find(params[:id]).destroy
    flash[:success] = "The computer's status details have been successfully deleted."
    redirect_to statuses_path
  end
  
  private
  
    def status_params
      params.require(:status).permit(:entertrack, :computer_id, :staff_id, :scrapped, :sold)
    end
    
    def set_status
      @status = Status.find(params[:id])
    end
    
end