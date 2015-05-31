class OperatingSystemsController < ApplicationController
  before_action :set_operating_system, only: [:edit, :update, :show]
  before_action :admin_user
  
  def index
    @operating_systems = OperatingSystem.paginate(page: params[:page], per_page: 50)
  end
  
  def show
    @wipes = @operating_system.wipes.paginate(page: params[:page], per_page: 50)
  end 
  
  def new
    @operating_system = OperatingSystem.new
  end
  
  def create
    @operating_system = OperatingSystem.new(operating_system_params)
    if @operating_system.save
      flash[:success] = "The new operating system was created successfully."
      redirect_to operating_systems_path
    else
      render 'new'
    end
  end
  
    
  def edit

  end
  
  def update
        if @operating_system.update(operating_system_params)
      flash[:success] = "Your operating system's details have been successfully updated."
      redirect_to operating_system_path(@operating_system) 
    else
      render 'new'
    end
  end

  def destroy
    OperatingSystem.find(params[:id]).destroy
    flash[:success] = "The operating system has been successfully deleted."
    redirect_to operating_systems_path
  end
  
  private
  
    # Whitelisting variables
    def operating_system_params
      params.require(:operating_system).permit(:os)
    end
    
    def set_operating_system
      @operating_system = OperatingSystem.find(params[:id])
    end
  
end