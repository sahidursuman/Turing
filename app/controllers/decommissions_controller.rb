class DecommissionsController < ApplicationController
  before_action :set_decommission, only: [:edit, :update, :show]
  before_action :require_user
  before_action :decom_staff
  before_action :admin_user, only: [:destroy]
  
  def index
    #@decommissions = Decommission.paginate(page: params[:page], per_page: 50)
    if params[:search]
      @decommissions = Decommission.search(params[:search]).order("computer_id DESC").paginate(page: params[:page], per_page: 50)
    else
      @decommissions = Decommission.all.order('computer_id DESC').paginate(page: params[:page], per_page: 50)
    end
  end
  
  def show

  end
  
  def new
    @decommission = Decommission.new
  end 
  
  def create
    @decommission = Decommission.new(decommission_params)
    @decommission.staff = current_user
    if @decommission.save
      flash[:success] = "Your decommission confirmation for ##{@decommission.entertrack} has been successfully logged."
      redirect_to new_decommission_path
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @decommission.update(decommission_params)
      flash[:success] = "Your decommission confirmation for ##{@decommission.entertrack} have been successfully updated."
      redirect_to decommission_path(@decommission) 
    else
      render 'new'
    end
  end
  
  def destroy
    Decommission.find(params[:id]).destroy
    flash[:success] = "The decommission confirmation for ##{@decommission.entertrack} have been successfully deleted."
    redirect_to decommissions_path
  end
  
  private
  
    def decommission_params
      params.require(:decommission).permit(:entertrack, :computer_id, :staff_id, :decommissioned)
    end
    
    def set_decommission
      @decommission = Decommission.find(params[:id])
    end
    
end