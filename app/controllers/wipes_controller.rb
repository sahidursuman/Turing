class WipesController < ApplicationController
  before_action :require_user, except: [:show]
  
  def show
    @wipe = Wipe.find(params[:id])
    @computers = @wipe.computers.paginate(page: params[:page], per_page: 20)
  end
  
  def new
    @wipe = Wipe.new
  end
  
  def create
    @wipe = Wipe.new(wipe_params)
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
      params.require(:wipe).permit(:date_wiped, :wiped_using, :wiped_by)
      
    end
    
end