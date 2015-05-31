class HubsController < ApplicationController
  before_action :set_hub, only: [:edit, :update, :show]
  before_action :admin_user
  
  def index
    @hubs = Hub.paginate(page: params[:page], per_page: 20)
  end
  
  def show

  end 
  
  def new
    @hub = Hub.new
  end
  
  def create
    @hub = Hub.new(hub_params)
    if @hub.save
      flash[:success] = "The new hub was created successfully."
      redirect_to hubs_path
    else
      render 'new'
    end
  end
  
    
  def edit

  end
  
  def update
    if @hub.update(hub_params)
      flash[:success] = "Your hub's details have been successfully updated."
      redirect_to hub_path(@hub) 
    else
      render 'new'
    end
  end

  def destroy
    Hub.find(params[:id]).destroy
    flash[:success] = "The hub has been successfully deleted."
    redirect_to hubs_path
  end
  
  private
  
    # Whitelisting variables
    def hub_params
      params.require(:hub).permit(:hub_location)
    end
    
    def set_hub
      @hub = Hub.find(params[:id])
    end
  
end