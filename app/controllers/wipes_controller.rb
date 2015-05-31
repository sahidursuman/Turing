class WipesController < ApplicationController
  before_action :require_user
  before_action :wipe_staff
  
  def show
    @wipe = Wipe.find(params[:id])
    @computer = @wipe.computer
  end
  
  def new
    @wipe = Wipe.new
  end
  
  def create
    @wipe = Wipe.new(wipe_params)
    #@wipe.staff = current_user
    if @wipe.save
      flash[:success] = "Thank you, your wipe has been saved."
      redirect_to computers_path
    else
      render 'new'
    end
  end
  
  private
    
    # Whitelisting parameters (strong)
    def wipe_params
      params.require(:wipe).permit(:staff_id, :action_taken, :computer_id)
    end
    
end