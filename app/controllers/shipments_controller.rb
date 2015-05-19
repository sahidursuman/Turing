class ShipmentsController < ApplicationController

  before_action :set_shipment, only: [:edit, :update, :show]
  before_action :require_user#, except [:show, :index]
  before_action :admin_user, only: [:destroy, :index]
  
  def index
    #@shipments = Shipment.paginate(page: params[:page], per_page: 50)
    if params[:search]
      @shipments = Shipment.search(params[:search]).order("computer_id DESC")
    else
      @shipments = Shipment.all.order('computer_id DESC')
    end
  end
  
  def show

  end
  
  def new
    @shipment = Shipment.new
  end 
  
  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.staff = current_user
    if @shipment.save
      flash[:success] = "Your shipment has been successfully logged."
      redirect_to shipment_path(@shipment)
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @shipment.update(shipment_params)
      flash[:success] = "Your shipments details have been successfully updated."
      redirect_to shipment_path(@shipment) 
    else
      render 'new'
    end
  end
  
  def destroy
    Shipment.find(params[:id]).destroy
    flash[:success] = "The shipments details have been successfully deleted."
    redirect_to shipments_path
  end
  
  private
  
    def shipment_params
      params.require(:shipment).permit(:entertrack, :computer_id, :staff_id, :shipped)
    end
    
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end
    
end