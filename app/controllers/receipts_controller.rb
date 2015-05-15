class ReceiptsController < ApplicationController

  before_action :set_receipt, only: [:edit, :update, :show]
  before_action :require_user#, except [:show, :index]
  before_action :admin_user, only: [:destroy, :index]
  
  def index
    @receipts = Receipt.paginate(page: params[:page], per_page: 50)
  end
  
  def show

  end
  
  def new
    @receipt = Receipt.new
  end 
  
  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.staff = current_user
    if @receipt.save
      flash[:success] = "Your receipt has been successfully logged."
      redirect_to receipt_path(@receipt)
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @receipt.update(receipt_params)
      flash[:success] = "Your receipts details have been successfully updated."
      redirect_to receipt_path(@receipt) 
    else
      render 'new'
    end
  end
  
  def destroy
    Receipt.find(params[:id]).destroy
    flash[:success] = "The receipts details have been successfully deleted."
    redirect_to receipts_path
  end
  
  private
  
    def receipt_params
      params.require(:receipt).permit(:entertrack, :computer_id, :staff_id, :received, :school)
    end
    
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end
    
end