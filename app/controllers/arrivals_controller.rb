class ArrivalsController < ApplicationController
  before_action :set_arrival, only: [:edit, :update, :show]
  before_action :require_user
  before_action :wipe_staff
  before_action :admin_user, only: [:destroy]
  
  def index
    #@arrivals = Arrival.paginate(page: params[:page], per_page: 50)
    if params[:search]
      @arrivals = Arrival.search(params[:search]).order("computer_id DESC").paginate(page: params[:page], per_page: 50)
    else
      @arrivals = Arrival.all.order('computer_id DESC').paginate(page: params[:page], per_page: 50)
    end
  end
  
  def show

  end
  
  def new
    @arrival = Arrival.new
  end 
  
  def create
    @arrival = Arrival.new(arrival_params)
    @arrival.staff = current_user
    if @arrival.save
      flash[:success] = "Your computer's arrival has been successfully logged."
      redirect_to arrival_path(@arrival)
    else
      render 'new'
    end
  end
  
  def edit
   
  end
  
  def update
    if @arrival.update(arrival_params)
      flash[:success] = "Your computer's arrival confirmation has been successfully updated."
      redirect_to arrival_path(@arrival) 
    else
      render 'new'
    end
  end
  
  def destroy
    Arrival.find(params[:id]).destroy
    flash[:success] = "The computer's arrival confirmation has been successfully deleted."
    redirect_to arrivals_path
  end
  
  private
  
    def arrival_params
      params.require(:arrival).permit(:entertrack, :computer_id, :staff_id, :arrived)
    end
    
    def set_arrival
      @arrival = Arrival.find(params[:id])
    end
    
end