class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:edit, :update, :show]
  before_action :require_user
  before_action :ship_staff
  before_action :admin_user, only: [:destroy]
  
  def index
    #@shipments = Shipment.paginate(page: params[:page], per_page: 50)
    if params[:search]
      @shipments = Shipment.search(params[:search]).order("computer_id DESC").paginate(page: params[:page], per_page: 50)
    else
      @shipments = Shipment.all.order('computer_id DESC').paginate(page: params[:page], per_page: 50)
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
      flash[:success] = "Your shipment for ##{@shipment.entertrack} has been successfully logged."
      redirect_to new_shipment_path
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @shipment.update(shipment_params)
      flash[:success] = "Your shipments details for ##{@shipment.entertrack} have been successfully updated."
      redirect_to shipment_path(@shipment) 
    else
      render 'new'
    end
  end
  
  def destroy
    Shipment.find(params[:id]).destroy
    flash[:success] = "The shipments details for ##{@shipment.entertrack} have been successfully deleted."
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